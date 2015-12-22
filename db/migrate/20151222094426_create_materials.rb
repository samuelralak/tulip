class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials, id: :uuid do |t|
      t.uuid :painter_id
      t.date :date
      t.decimal :total_spent
      t.text :reason

      t.timestamps null: false
    end
    add_index :materials, :painter_id
  end
end
