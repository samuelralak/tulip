jQuery -> 
	if $(".site_totals") isnt undefined
		site_totals = $(".site_totals").text()
		total_sum = 0.0
		other = 0.0

		$(".sum").each () ->
			total_sum += parseFloat($(this).text())

		other = parseFloat($(".site_totals").text()) - total_sum
		$(".other").text(other)
		
