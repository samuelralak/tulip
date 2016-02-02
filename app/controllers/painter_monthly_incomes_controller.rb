class PainterMonthlyIncomesController < ApplicationController
	def update
		@painter = params[:painter]
		@start_date = Date.parse(params[:start_date])
		monthly_income = PainterMonthlyIncome.find_by('painter_id = ? AND month = ? AND year = ?', 
			@painter, @start_date.strftime("%B"), @start_date.strftime("%Y")
		)
		monthly_income.update_attributes(absent_total: params[:value])

		respond_to do |format|
			format.js {}
		end
	end
end
