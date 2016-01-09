class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments, id: :uuid do |t|
      t.string :from
      t.string :to
      t.text :reason
      t.decimal :amount
      t.uuid :payment_type_id

      t.timestamps null: false
    end
    add_index :payments, :payment_type_id
  end
end
