class AddIsActiveToSite < ActiveRecord::Migration
  def change
    add_column :sites, :is_active, :boolean, null: false, default: true
  end
end
