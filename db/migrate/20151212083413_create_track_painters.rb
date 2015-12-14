class CreateTrackPainters < ActiveRecord::Migration
  def change
    create_table :track_painters, id: :uuid do |t|
      t.integer :week_number
      t.integer :year
      t.decimal :weekly_total
      t.uuid :painter_id

      t.timestamps null: false
    end

    add_index :track_painters, :painter_id
  end
end
