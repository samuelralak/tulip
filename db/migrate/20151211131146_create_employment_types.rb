class CreateEmploymentTypes < ActiveRecord::Migration
	def migrate(direction)
		super

		types = ["Permanent", "Temporary"]
		types.map { |t|  
			EmploymentType.create!(
				name: t, code: t.upcase.gsub(' ', '-')
			) if direction == :up
		}
	end

	def change
		create_table :employment_types, id: :uuid do |t|
			t.string :name
			t.string :code
			t.boolean :is_active, default: true

			t.timestamps null: false
		end
	end
end
