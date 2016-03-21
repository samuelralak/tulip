class AddWeeklyCostToTrackPainters < ActiveRecord::Migration
  def change
    add_column :track_painters, :weekly_cost, :numeric
  end
end
