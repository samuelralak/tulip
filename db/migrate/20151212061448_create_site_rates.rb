class CreateSiteRates < ActiveRecord::Migration
  def change
    create_table :site_rates, id: :uuid do |t|
      t.string :internal
      t.string :external
      t.uuid :site_id

      t.timestamps null: false
    end

    add_index :site_rates, :site_id
  end
end
