class CreateSkills < ActiveRecord::Migration
	def migrate(direction)
		super

		skills = ["Sanding", "Roller", "Skimming", "Undercoat"]
		skills.map { |s|  
			Skill.create!(
				name: s, code: s.upcase.gsub(' ', '-')
			) if direction == :up
		}
	end

	def change
		create_table :skills, id: :uuid do |t|
			t.string :name
			t.string :code
			t.boolean :is_active

			t.timestamps null: false
		end
	end
end
