class AddColumnsToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :note, :text, null: false, default: "Supply of paint..."
    add_column :invoices, :amount, :decimal, null: false, default: 0.0
  end
end
