class PettyCash < ActiveRecord::Base
	has_many :petty_cash_items, inverse_of: :petty_cash, dependent: :destroy

	before_save :get_bal_carried_forward

	private
		def get_bal_carried_forward
			self.amount = self.amount.nil? ? 0.0 : self.amount
			self.total = self.total.nil? ? 0.0 : self.total

			petty_cashes = PettyCash.order("created_at DESC")
			unless petty_cashes.length.eql?(0)
				if !petty_cashes[0].try(:id).eql?(self.try(:id)) && self.updated_at.eql?(nil)
					latest_balance = petty_cashes[0].balance
					self.bal_carried_forward = latest_balance.nil? ? petty_cashes[0].total : latest_balance
				end
			else
				self.bal_carried_forward = 0.0
			end

			self.total = (self.amount + self.bal_carried_forward)
		end
end
