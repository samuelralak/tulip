class RemovePainterIdFromMaterial < ActiveRecord::Migration
  def change
    remove_index :materials, :painter_id
    remove_column :materials, :painter_id, :uuid
  end
end
