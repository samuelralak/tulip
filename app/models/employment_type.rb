class EmploymentType < ActiveRecord::Base
	has_many :painters, inverse_of: :employment_type
end
