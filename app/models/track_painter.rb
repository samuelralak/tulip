class TrackPainter < ActiveRecord::Base
	belongs_to :painter, inverse_of: :track_painters

	has_many :track_painter_items, inverse_of: :track_painter
end
