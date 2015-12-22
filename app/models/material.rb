class Material < ActiveRecord::Base
	belongs_to :site, inverse_of: :materials
end
