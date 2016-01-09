class Site < ActiveRecord::Base
	has_one :site_agreed_amount, inverse_of: :site
	accepts_nested_attributes_for :site_agreed_amount

	has_one :site_square_metre, inverse_of: :site
	accepts_nested_attributes_for :site_square_metre

	has_one :site_rate, inverse_of: :site
	accepts_nested_attributes_for :site_rate

	has_many :track_painter_items, inverse_of: :site
	has_many :materials, 		   inverse_of: :site

	has_many :payments, foreign_key: "client_id"
end
