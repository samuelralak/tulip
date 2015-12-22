class AddAdditionalCostsToSite < ActiveRecord::Migration
  def change
    add_column :sites, :additional_costs, :decimal, null: false, default: 0.0
  end
end
