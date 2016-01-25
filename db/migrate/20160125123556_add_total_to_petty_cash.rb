class AddTotalToPettyCash < ActiveRecord::Migration
  def change
    add_column :petty_cashes, :total, :decimal, null: false, default: 0.0
  end
end
