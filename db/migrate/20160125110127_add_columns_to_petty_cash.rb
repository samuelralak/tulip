class AddColumnsToPettyCash < ActiveRecord::Migration
  def change
    add_column :petty_cashes, :source, :string
    add_column :petty_cashes, :balance, :decimal
  end
end
