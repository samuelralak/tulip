class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites, id: :uuid do |t|
      t.string :name
      t.string :head
      t.string :address
      t.text :notes

      t.timestamps null: false
    end
  end
end
