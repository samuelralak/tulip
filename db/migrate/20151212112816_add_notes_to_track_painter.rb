class AddNotesToTrackPainter < ActiveRecord::Migration
  def change
    add_column :track_painters, :notes, :text
  end
end
