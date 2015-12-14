class Skill < ActiveRecord::Base
	has_many :painter_skills
  	has_many :painters, through: :painter_skills
end
