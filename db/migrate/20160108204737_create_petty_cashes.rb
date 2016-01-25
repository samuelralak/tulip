class CreatePettyCashes < ActiveRecord::Migration
  def change
    create_table :petty_cashes, id: :uuid do |t|
      t.string :paid_to
      t.decimal :amount, null: false, default: 0.0
      t.text :reason
      t.date :date_paid

      t.timestamps null: false
    end
  end
end
