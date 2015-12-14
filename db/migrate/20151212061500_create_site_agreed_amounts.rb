class CreateSiteAgreedAmounts < ActiveRecord::Migration
  def change
    create_table :site_agreed_amounts, id: :uuid do |t|
      t.string :internal
      t.string :external
      t.uuid :site_id

      t.timestamps null: false
    end

    add_index :site_agreed_amounts, :site_id
  end
end
