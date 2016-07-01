class PainterMonthlyIncomesController < ApplicationController
	def update
		@painter = params[:painter]
		@start_date = Date.parse(params[:start_date])
		monthly_income = PainterMonthlyIncome.where('painter_id = ? AND month = ? AND year = ?', 
			@painter, @start_date.strftime("%B"), @start_date.strftime("%Y")
		).order("created_at ASC").last

		logger.info "####### VALUE: #{params[:value]}"
		monthly_income.updated_absent_total = BigDecimal(params[:value])
		monthly_income.save!
	end
end
