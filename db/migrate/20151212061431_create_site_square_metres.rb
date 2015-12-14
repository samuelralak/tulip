class CreateSiteSquareMetres < ActiveRecord::Migration
  def change
    create_table :site_square_metres, id: :uuid do |t|
      t.string :internal
      t.string :external
      t.uuid :site_id

      t.timestamps null: false
    end

    add_index :site_square_metres, :site_id
  end
end
