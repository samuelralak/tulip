module PaintersHelper
	def days_worked(painter, start_date)
		track_painters = painter.track_painters.all
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
			total_allowance = days_worked.sum(:daily_allowance)	+ sundays_total
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
		deductions = deductions_total(painter, start_date)
		bonus = bonus_total(painter, start_date)
		if painter.employment_type.code.eql?('MONTHLY')
			track_painters = painter.track_painters.all
			total_pay = TrackPainterItem.where('track_painter_id IN (?) AND date_attended BETWEEN ? AND ?', 
				track_painters.pluck(:id), start_date.beginning_of_month, start_date.end_of_month 
			).sum(:daily_allowance)
			total_pay = (total_pay + bonus) - deductions
		else
			total_pay = (basic_pay + allowance + wages + bonus) - deductions
		end

		return total_pay
	end
end
