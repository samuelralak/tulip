class CreateDeductionInstallments < ActiveRecord::Migration
  def change
    create_table :deduction_installments, id: :uuid do |t|
      t.date :date
      t.decimal :amount
      t.uuid :deduction_id

      t.timestamps null: false
    end
    add_index :deduction_installments, :deduction_id
  end
end
