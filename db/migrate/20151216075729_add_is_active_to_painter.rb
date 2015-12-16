class AddIsActiveToPainter < ActiveRecord::Migration
  def change
    add_column :painters, :is_active, :boolean, default: true
  end
end
