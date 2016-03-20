class TrackPainter < ActiveRecord::Base
	belongs_to :painter, inverse_of: :track_painters

	has_many :track_painter_items, inverse_of: :track_painter, dependent: :destroy

	validates :weekly_total, :painter_id, :week_number, :year, presence: true
end
