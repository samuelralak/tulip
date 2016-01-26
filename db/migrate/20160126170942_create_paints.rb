class CreatePaints < ActiveRecord::Migration
  def change
    create_table :paints, id: :uuid do |t|
      t.string :month
      t.string :year
      t.decimal :amount, null: false, default: 0.0
      t.uuid :site_id

      t.timestamps null: false
    end
    add_index :paints, :site_id
  end
end
