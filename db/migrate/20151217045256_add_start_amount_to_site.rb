class AddStartAmountToSite < ActiveRecord::Migration
  def change
    add_column :sites, :start_amount, :decimal, null: false, default: 0.0
  end
end
