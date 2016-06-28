class AddSiteIdToPettyCashItem < ActiveRecord::Migration
  def change
    add_column :petty_cash_items, :site_id, :uuid
    add_index :petty_cash_items, :site_id
  end
end
