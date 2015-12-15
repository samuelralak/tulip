class SetDefaultValuesToPainter < ActiveRecord::Migration
  def change
  	change_column :painters, :basic_pay, :decimal, null: false, default: 0.0
  	change_column :painters, :daily_wage, :decimal, null: false, default: 0.0
  	change_column :painters, :daily_allowance, :decimal, null: false, default: 0.0
  end
end
