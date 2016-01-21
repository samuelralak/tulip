class AddColumnsToSite < ActiveRecord::Migration
  def change
    add_column :sites, :client, :string
    add_column :sites, :city, :string
    add_column :sites, :mobile, :string
  end
end
