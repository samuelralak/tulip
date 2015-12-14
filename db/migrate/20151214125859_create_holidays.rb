class CreateHolidays < ActiveRecord::Migration
	def migrate(direction)
		super

		days = [
			{ date: 'January, 01', name: 'New Year', comments: '' },
			{ date: 'May, 01', name: 'Labour Day', comments: '' },
			{ date: 'June, 01', name: 'Madaraka Day', comments: '' },
			{ date: 'October, 20', name: 'Mashujaa Day', comments: '' },
			{ date: 'December, 12', name: 'Jamhuri Day', comments: '' },
			{ date: 'December, 25', name: 'Christmas Day', comments: '' },
			{ date: 'December, 26', name: 'Boxing Day', comments: '' }
		]
		Holiday.create(days)
	end

	def change
		create_table :holidays, id: :uuid do |t|
			t.string :date
			t.string :name
			t.string :comments

			t.timestamps null: false
		end
	end
end


