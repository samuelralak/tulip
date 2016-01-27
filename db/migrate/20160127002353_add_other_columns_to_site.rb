class AddOtherColumnsToSite < ActiveRecord::Migration
  def change
    add_column :sites, :initial_labour_amount, :decimal, null: false, default: 0.0
    add_column :sites, :initial_material_amount, :decimal, null: false, default: 0.0
  end
end
