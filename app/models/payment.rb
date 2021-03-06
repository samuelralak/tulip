class Payment < ActiveRecord::Base
	belongs_to :payment_type
	belongs_to :client, class_name: 'Site'
	validates :client_id, :amount, :reference, :bank, :payment_date, presence: true
end
