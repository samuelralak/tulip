class CreatePainterSkills < ActiveRecord::Migration
  def change
    create_table :painter_skills, id: :uuid do |t|
      t.uuid :painter_id
      t.uuid :skill_id

      t.timestamps null: false
    end
    add_index :painter_skills, :painter_id
    add_index :painter_skills, :skill_id
  end
end
