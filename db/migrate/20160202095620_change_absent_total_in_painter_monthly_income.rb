class ChangeAbsentTotalInPainterMonthlyIncome < ActiveRecord::Migration
  def change
  	change_column :painter_monthly_incomes, :absent_total, 'decimal USING CAST(absent_total AS decimal)', null: false, default: 0.0
  end
end
