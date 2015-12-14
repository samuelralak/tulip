class CreateNextOfKins < ActiveRecord::Migration
  def change
    create_table :next_of_kins, id: :uuid do |t|
      t.string :name
      t.string :relation
      t.string :telephone
      t.uuid :painter_id

      t.timestamps null: false
    end

    add_index :next_of_kins, :painter_id
  end
end
