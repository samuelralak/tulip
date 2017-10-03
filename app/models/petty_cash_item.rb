class PettyCashItem < ActiveRecord::Base
	belongs_to :petty_cash, inverse_of: :petty_cash_items
	belongs_to :site, inverse_of: :petty_cash_items

	after_create :debit_petty_cash

	private
		def debit_petty_cash
			petty_cash = self.petty_cash

			if petty_cash.balance.nil? || petty_cash.balance.eql?(0.0)
				petty_cash_balance = (petty_cash.total - self.amount)	
			else
				petty_cash_balance = (petty_cash.balance - self.amount)	
			end
			
			petty_cash.update_attributes(balance: petty_cash_balance)
		end
end
