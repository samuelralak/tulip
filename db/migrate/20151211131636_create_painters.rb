class CreatePainters < ActiveRecord::Migration
  def change
    create_table :painters, id: :uuid do |t|
      t.string :name
      t.decimal :basic_pay
      t.decimal :daily_wage
      t.decimal :daily_allowance
      t.uuid :employment_type_id

      t.timestamps null: false
    end

    add_index :painters, :employment_type_id
  end
end
