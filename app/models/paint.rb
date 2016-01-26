class Paint < ActiveRecord::Base
	belongs_to :site, inverse_of: :paints
end
