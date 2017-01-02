module PaintersHelper
	def days_worked(painter, start_date)
		track_painters = painter.track_painters.where(year: start_date.beginning_of_month.strftime("%Y").to_i).all
		no_of_days = TrackPainterItem.where('track_painter_id IN (?) AND date_attended BETWEEN ? AND ?',
			track_painters.pluck(:id), start_date.beginning_of_month, start_date.end_of_month
		).length

		return no_of_days
	end

	def holidays_worked(painter, start_date)
		track_painters = painter.track_painters.all
		track_painter_items = TrackPainterItem.where('track_painter_id IN (?) AND date_attended BETWEEN ? AND ?',
			track_painters.pluck(:id), start_date.beginning_of_month, start_date.end_of_month
		)

		holidays = Holiday.pluck(:date).map { |d| DateTime.parse(d) }
		no_of_days = track_painter_items.where('date_attended IN (?)', holidays).length

		return no_of_days
	end

	def sundays_worked(painter, start_date)
		track_painters = painter.track_painters.all
		days_worked = TrackPainterItem.where('track_painter_id IN (?) AND date_attended BETWEEN ? AND ?',
			track_painters.pluck(:id), start_date.beginning_of_month, start_date.end_of_month
		)
		sundays_total = 0.0
		sundays_worked = days_worked.select { |d| d.date_attended.wday.eql?(0) }

		return sundays_worked.length
	end
	def sundays_amount(painter, start_date)
	track_painters = painter.track_painters.all
		days_worked = TrackPainterItem.where('track_painter_id IN (?) AND date_attended BETWEEN ? AND ?',
			track_painters.pluck(:id), start_date.beginning_of_month, start_date.end_of_month
		)
		sundays_total = 0.0
		sundays_worked = days_worked.select { |d| d.date_attended.wday.eql?(0) }
		sundays_worked.each { |s| sundays_total += s.daily_wage }
		return sundays_total
	end

	def allowance_total(painter, start_date)
		track_painters = painter.track_painters.all
		days_worked = TrackPainterItem.where('track_painter_id IN (?) AND date_attended BETWEEN ? AND ?',
			track_painters.pluck(:id), start_date.beginning_of_month, start_date.end_of_month
		)
		sundays_total = 0.0
		sundays_worked = days_worked.select { |d| d.date_attended.wday.eql?(0) }
		sundays_worked.each { |s| sundays_total += s.daily_wage }
		if painter.employment_type.code.eql?('MONTHLY')
			total_allowance = days_worked.sum(:daily_allowance)
		else
			total_allowance = days_worked.sum(:daily_allowance)
		end

		return total_allowance
	end

	def wages_total(painter, start_date)
		track_painters = painter.track_painters.all
		track_painter_items = TrackPainterItem.where('track_painter_id IN (?) AND date_attended BETWEEN ? AND ?',
			track_painters.pluck(:id), start_date.beginning_of_month, start_date.end_of_month
		)

		holidays = Holiday.pluck(:date).map { |d| DateTime.parse(d) }
		total_wage = track_painter_items.where('date_attended IN (?)', holidays).sum(:daily_wage)
		total_allowance = track_painter_items.where('date_attended IN (?)', holidays).sum(:daily_allowance)
		total = total_wage

		return total
	end

	def deductions_total(painter, start_date)
		deductions = Deduction.where(painter_id: painter.id)
		installments = DeductionInstallment.where('deduction_id IN (?) AND date = ?',
			deductions.pluck(:id), start_date.end_of_month
		).sum(:amount)

		return installments
	end

	def bonus_total(painter, start_date)
		bonus = Bonu.where('painter_id = ? AND date_applicable = ?',
			painter.id, start_date.end_of_month
		).sum(:amount)

		return bonus
	end

	def payable_total(painter, start_date)
		basic_pay = painter.basic_pay
		allowance = allowance_total(painter, start_date)
		wages = wages_total(painter, start_date)
		sundays = sundays_amount(painter, start_date)
		deductions = deductions_total(painter, start_date)
		bonus = bonus_total(painter, start_date)
		if painter.employment_type.code.eql?('MONTHLY')
			track_painters = painter.track_painters.all
			total_pay = TrackPainterItem.where('track_painter_id IN (?) AND date_attended BETWEEN ? AND ?',
				track_painters.pluck(:id), start_date.beginning_of_month, start_date.end_of_month
			).sum(:daily_allowance)
			total_pay = (total_pay + bonus) - deductions
		else
			# missed_days = days_missed(painter, start_date) *
			total_pay = (basic_pay + allowance + sundays + wages + bonus) - (deductions + absent_total(painter, start_date))
		end

		return total_pay
	end

	def days_missed(painter, start_date)
		days_in_month = (start_date.beginning_of_month..start_date.end_of_month).map { |e| Date.parse(e.to_s) }
		track_painters = painter.track_painters.all
		days_attended = TrackPainterItem.where('track_painter_id IN (?) AND date_attended BETWEEN ? AND ?',
			track_painters.pluck(:id), start_date.beginning_of_month, start_date.end_of_month
		).pluck(:date_attended)

		missed_days = days_in_month.select { |d| !days_attended.include?(d) }
		missed_days = missed_days.select { |d| !d.wday.eql?(0) }
		holidays = Holiday.pluck(:date).map { |d| DateTime.parse(d) }
		missed_days = missed_days.select { |d| !holidays.include?(d) }

		return 	missed_days
	end

	def absent_total(painter, start_date)
		missed_days = days_missed(painter, start_date)
		total = painter.try(:daily_wage) * missed_days.length

		monthly_income = PainterMonthlyIncome.where('painter_id = ? AND month = ? AND year = ?',
			painter.id, start_date.strftime("%B"), start_date.strftime("%Y")).order("created_at ASC")

		if monthly_income.empty?
			PainterMonthlyIncome.create(painter_id: painter.id, month: start_date.strftime("%B"),
				year: start_date.strftime("%Y"), absent_total: total, basic_pay: painter.basic_pay)
			monthly_income = PainterMonthlyIncome.where('painter_id = ? AND month = ? AND year = ?',
				painter.id, start_date.strftime("%B"), start_date.strftime("%Y")).order("created_at ASC")
			return monthly_income.last.absent_total
		else
			if monthly_income.last.try(:updated_absent_total).nil?
				monthly_income.last.update_attributes(absent_total: total)
				return monthly_income.last.absent_total
			else
				return monthly_income.last.try(:updated_absent_total)
			end
		end
	end
end
