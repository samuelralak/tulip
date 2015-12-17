class CreateBonus < ActiveRecord::Migration
  def change
    create_table :bonus, id: :uuid do |t|
      t.decimal :amount
      t.date :date_applicable
      t.uuid :painter_id

      t.timestamps null: false
    end

    add_index :bonus, :painter_id
  end
end
