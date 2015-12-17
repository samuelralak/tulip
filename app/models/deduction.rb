class Deduction < ActiveRecord::Base
	belongs_to :painter, inverse_of: :deductions

	has_many :deduction_installments, inverse_of: :deduction, dependent: :destroy
end
