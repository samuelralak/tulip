class SiteRate < ActiveRecord::Base
	belongs_to :site, inverse_of: :site_rate
end
