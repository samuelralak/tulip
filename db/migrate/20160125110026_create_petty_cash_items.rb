class CreatePettyCashItems < ActiveRecord::Migration
  def change
    create_table :petty_cash_items, id: :uuid do |t|
      t.uuid :petty_cash_id
      t.decimal :amount, null: false, default: 0.0
      t.string :paid_to
      t.text :reason
      t.date :date

      t.timestamps null: false
    end

    add_index :petty_cash_items, :petty_cash_id
  end
end
