class AddBasicPayToPainterMonthlyIncome < ActiveRecord::Migration
  def change
    add_column :painter_monthly_incomes, :basic_pay, :decimal, null: false, default: 0.0
  end
end
