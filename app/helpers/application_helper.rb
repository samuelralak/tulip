module ApplicationHelper
	def total_wage(holidays, painter)
		total = holidays * painter.daily_wage
		return total
	end

	def total_allowance(total_days, holidays, painter)
		total = (total_days - holidays ) * painter.daily_allowance
		return total
	end

	def total_payable(total_days, holidays, painter)
		basic_pay = painter.basic_pay
		allowance = total_allowance(total_days, holidays, painter)
		wages = total_wage(holidays, painter)
		total = basic_pay + allowance + wages
		return total
	end
end
