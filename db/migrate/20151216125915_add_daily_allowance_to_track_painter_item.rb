class AddDailyAllowanceToTrackPainterItem < ActiveRecord::Migration
  def change
    add_column :track_painter_items, :daily_allowance, :decimal, null: false, default: 0.0
  end
end
