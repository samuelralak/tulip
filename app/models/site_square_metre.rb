class SiteSquareMetre < ActiveRecord::Base
	belongs_to :site, inverse_of: :site_square_metre
end
