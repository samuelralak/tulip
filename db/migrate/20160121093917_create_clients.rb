class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients, id: :uuid do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :mobile

      t.timestamps null: false
    end
  end
end
