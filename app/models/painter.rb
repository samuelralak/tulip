class Painter < ActiveRecord::Base
	belongs_to :employment_type, inverse_of: :painters

	has_one :painter_contact, inverse_of: :painter
	accepts_nested_attributes_for :painter_contact

	has_one :next_of_kin, inverse_of: :painter
	accepts_nested_attributes_for :next_of_kin

	has_many :track_painters, inverse_of: :painter
	has_many :deductions, 	  inverse_of: :painter
	has_many :bonus, 	  	  inverse_of: :painter

	has_many :painter_skills
  	has_many :skills, through: :painter_skills
end
