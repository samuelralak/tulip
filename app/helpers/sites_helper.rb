module SitesHelper
	def find_site(week, date, painter)
		# find track painter
		track_painter = TrackPainter.where(["year = ? and week_number = ? and painter_id = ?", date.strftime('%Y').to_i, week, painter]).first

		if track_painter
			if track_painter.painter.name.eql?('Willis')
				puts "\n\n"
				puts "TRACK PAINTER ITEMS: #{track_painter.track_painter_items.where(date_attended: date).each{ |t| t.site.name }}"
				puts "\n\n"
			end
			track_painter_item = track_painter.track_painter_items.where(date_attended: date)[0]

			if track_painter_item
				return track_painter_item.site_id
			end
		end
	end

	def site_labour_amount(site)
		total = 0.0
		track_painter_items = TrackPainterItem.where(site_id: site.id)

		track_painter_items.each do |tpi|
			if !tpi.track_painter.painter.nil? && tpi.track_painter.painter.employment_type.code.eql?('PERMANENT')
				total += (tpi.daily_wage + tpi.daily_allowance)
			else
				total += tpi.daily_allowance
			end
		end

		total = total + site.initial_labour_amount

		return total
	end

    def total_paid(site)
		total = 0.0
		payments = Payment.where(client_id: site.id)

		payments.each do |p|
			total += p.amount
		end


		return total
	end

	def sum_petty_cash(site)
		total = 0

		site.petty_cash_items.each do |p|
			if %(wage wages).include? p.reason.split(" ")[0].downcase
				next
			end

			total += p.amount
		end
		total
	end
end
