class AddOldPaintsAmountToSite < ActiveRecord::Migration
  def change
    add_column :sites, :old_paint_amount, :decimal, null: false, default: 0.0
  end
end
