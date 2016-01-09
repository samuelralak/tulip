class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices, id: :uuid do |t|
      t.integer :invoice_number, null: false
      t.date :invoice_date
      t.decimal :sub_total, null: false, default: 0.0
      t.decimal :value_added_tax, null: false, default: 0.0
      t.decimal :total, null: false, default: 0.0
      t.uuid :site_id

      t.timestamps null: false
    end

    add_index :invoices, :invoice_number, unique: true
    add_index :invoices, :site_id

    execute "DROP SEQUENCE IF EXISTS invoice_number"
    execute "CREATE SEQUENCE invoice_number MINVALUE 1 START WITH 1 INCREMENT BY 1"
  end
end
