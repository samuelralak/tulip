class PainterContact < ActiveRecord::Base
	belongs_to :painter, inverse_of: :painter_contact
end
