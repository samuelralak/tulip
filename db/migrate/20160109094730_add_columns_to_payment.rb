class AddColumnsToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :bank, :string
    add_column :payments, :account_number, :string
    add_column :payments, :client_id, :uuid
    add_index :payments, :client_id
  end
end
