class DeductionInstallment < ActiveRecord::Base
	belongs_to :deduction, inverse_of: :deduction_installments
end
