class CreateTrackPainterItems < ActiveRecord::Migration
  def change
    create_table :track_painter_items do |t|
      t.uuid :site_id
      t.date :date_attended
      t.decimal :daily_wage
      t.uuid :track_painter_id

      t.timestamps null: false
    end

    add_index :track_painter_items, :site_id
    add_index :track_painter_items, :track_painter_id
  end
end
