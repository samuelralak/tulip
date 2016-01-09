class Payment < ActiveRecord::Base
	belongs_to :payment_type
	belongs_to :client, class_name: 'Site'
end
