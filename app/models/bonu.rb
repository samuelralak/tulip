class Bonu < ActiveRecord::Base
	belongs_to :painter, inverse_of: :bonus
end
