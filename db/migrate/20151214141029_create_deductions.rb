class CreateDeductions < ActiveRecord::Migration
  def change
    create_table :deductions, id: :uuid do |t|
      t.date :date
      t.string :reason
      t.decimal :amount
      t.uuid :painter_id

      t.timestamps null: false
    end
    add_index :deductions, :painter_id
  end
end
