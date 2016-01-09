class CreatePaymentTypes < ActiveRecord::Migration
	def migrate(direction)
		super

		types = ["Cash", "Cheque"]
		types.map { |t|  
			PaymentType.create!(
				name: t, code: t.upcase.gsub(' ', '-')
			) if direction == :up
		}
	end

  	def change
    	create_table :payment_types, id: :uuid do |t|
      		t.string :name
      		t.string :code
      		t.boolean :is_active, null: false, default: true

      		t.timestamps null: false
    	end
  	end
end
