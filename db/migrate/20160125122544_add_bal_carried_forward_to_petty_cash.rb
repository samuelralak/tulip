class AddBalCarriedForwardToPettyCash < ActiveRecord::Migration
  def change
    add_column :petty_cashes, :bal_carried_forward, :decimal, null: false, default: 0.0
  end
end
