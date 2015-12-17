class AddRateToDeduction < ActiveRecord::Migration
  def change
    add_column :deductions, :rate, :decimal, null: false, default: 0.0
  end
end
