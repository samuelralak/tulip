class PainterSkill < ActiveRecord::Base
	belongs_to :painter
	belongs_to :skill
end
