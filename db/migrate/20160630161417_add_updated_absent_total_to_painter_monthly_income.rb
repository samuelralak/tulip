class AddUpdatedAbsentTotalToPainterMonthlyIncome < ActiveRecord::Migration
  def change
    add_column :painter_monthly_incomes, :updated_absent_total, :decimal
  end
end
