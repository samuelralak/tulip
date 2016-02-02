jQuery -> 
	$.fn.editable.defaults.mode = 'inline'
	$('#missedDays').editable({
		type: 'text',
		url: '/update_monthly_income',    
		pk: 1,    
		title: 'edit figure',
		ajaxOptions: {
        	type: 'PUT'
    	}        
	})

	# $.ajax
 #    	url: '/update_monthly_income'
 #    	type: "PUT"
 #    	responseTime: 200
 #    	response: (settings) -> 
 #    		console.log settings
 #    	dataType: "JSON"


	$("#painter_employment_type_id").change () ->	
		selected = $(this).find("option:selected").text()

		switch selected
			when "Permanent" 
				$(".painter_daily_wage").show()
				$(".painter_basic_pay").show()
			when "Temporary" 
				$(".painter_daily_wage").hide()
				$(".painter_basic_pay").hide()
			when "Monthly" 
				$(".painter_daily_wage").hide()
				$(".painter_basic_pay").hide()
			when "Weekly" 
				$(".painter_daily_wage").hide()
				$(".painter_basic_pay").hide()
			else
				$(".painter_daily_wage").show()
				$(".painter_basic_pay").show()