class AddBalanceCarriedForwardToPettyCashItem < ActiveRecord::Migration
  def change
    add_column :petty_cash_items, :bal_carried_forward, :decimal
  end
end
