class SiteAgreedAmount < ActiveRecord::Base
	belongs_to :site, inverse_of: :site_agreed_amount
end
