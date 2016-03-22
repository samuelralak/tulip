class AddPriorityToSites < ActiveRecord::Migration
  def change
    add_column :sites, :priority, :numeric, null: false, default: 20
  end
end
