class PettyCashItem < ActiveRecord::Base
	belongs_to :petty_cash, inverse_of: :petty_cash_items

	after_create :debit_petty_cash

	private
		def debit_petty_cash
			petty_cash = self.petty_cash
			petty_cash_balance = (petty_cash.total - PettyCashItem.sum(:amount))
			petty_cash.update_attributes(balance: petty_cash_balance)
		end
end
