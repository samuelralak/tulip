class NextOfKin < ActiveRecord::Base
	belongs_to :painter, inverse_of: :next_of_kin
end
