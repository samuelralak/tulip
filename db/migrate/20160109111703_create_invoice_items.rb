class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items, id: :uuid do |t|
      t.text :description
      t.decimal :amount
      t.uuid :invoice_id

      t.timestamps null: false
    end

    add_index :invoice_items, :invoice_id
  end
end
