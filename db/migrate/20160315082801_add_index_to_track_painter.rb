class AddIndexToTrackPainter < ActiveRecord::Migration
  def change
  	add_index :track_painters, [:painter_id, :year, :week_number], unique: true
  end
end
