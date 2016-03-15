class TrackPainterItem < ActiveRecord::Base
	belongs_to :track_painter, inverse_of: :track_painter_items
	belongs_to :site, 		inverse_of: :track_painter_items

	after_commit :update_weekly_total

	private
		def update_weekly_total
			track_painter = TrackPainter.find(self.track_painter_id)
			unless track_painter.nil?
				weekly_total = track_painter.track_painter_items.sum(:daily_allowance)
				track_painter.update_attributes!(weekly_total: weekly_total)
			end
		end
end
