class AddSiteIdToMaterial < ActiveRecord::Migration
  def change
    add_column :materials, :site_id, :uuid
    add_index :materials, :site_id
  end
end
