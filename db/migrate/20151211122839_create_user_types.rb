class CreateUserTypes < ActiveRecord::Migration
	def migrate(direction)
		super

		user_types = ["Super User", "Administrator", "Staff"]
		user_types.map { |s|  
			UserType.create!(
				name: s, code: s.upcase.gsub(' ', '-')
			) if direction == :up
		}
	end

	def change
		create_table :user_types, id: :uuid do |t|
			t.string :name
			t.string :code
			t.boolean :is_active, default: true

			t.timestamps null: false
		end
	end
end
