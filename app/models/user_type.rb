class UserType < ActiveRecord::Base
	has_many :users, inverse_of: :user_type
end
