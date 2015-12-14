class CreatePainterContacts < ActiveRecord::Migration
  def change
    create_table :painter_contacts, id: :uuid do |t|
      t.text :address
      t.string :telephone_one
      t.string :telephone_two
      t.string :telephone_three
      t.uuid :painter_id

      t.timestamps null: false
    end

    add_index :painter_contacts, :painter_id
  end
end
