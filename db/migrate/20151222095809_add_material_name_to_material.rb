class AddMaterialNameToMaterial < ActiveRecord::Migration
  def change
    add_column :materials, :material_name, :string
  end
end
