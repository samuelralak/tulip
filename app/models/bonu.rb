class Bonu < ActiveRecord::Base
	belongs_to :painter, inverse_of: :bonus

	before_save :assign_date_applicable

	private
		def assign_date_applicable
			self.date_applicable = self.date_applicable.end_of_month
		end
end
