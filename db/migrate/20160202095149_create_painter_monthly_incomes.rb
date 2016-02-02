class CreatePainterMonthlyIncomes < ActiveRecord::Migration
  def change
    create_table :painter_monthly_incomes, id: :uuid do |t|
      t.uuid :painter_id
      t.string :month
      t.string :year
      t.string :absent_total

      t.timestamps null: false
    end
    add_index :painter_monthly_incomes, :painter_id
  end
end
