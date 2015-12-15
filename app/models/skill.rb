class Skill < ActiveRecord::Base
	has_many :painter_skills
  	has_many :painters, through: :painter_skills

  	before_save :assign_code

  	private
  		def assign_code
  			self.code = self.name.upcase.gsub(' ', '-')
  			self.is_active = true
  		end
end
