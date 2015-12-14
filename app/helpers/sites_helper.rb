module SitesHelper
	def find_site(week, date, painter)
		# find track painter
		track_painter = TrackPainter.where(["week_number = ? and painter_id = ?", week, painter]).first

		if track_painter
			track_painter_item = track_painter.track_painter_items.find_by(date_attended: date)

			if track_painter_item
				return track_painter_item.site_id
			end
		end
	end
end
