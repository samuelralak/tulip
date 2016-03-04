jQuery ->
	$('.siteStatusBtn').on 'click', () -> 
		btn = $(this)
		row = btn.closest('tr')
		siteId = btn.data('id')
		siteStatus = btn.data('active') is false
		btnOptionTxt =
			true: "deactivate"
			false: "activate"
		siteData = 
			is_active: siteStatus

		$.ajax
			url: "/sites/#{siteId}"
			type: "PUT"
			data:
				site: siteData
			success: (data, status, response) -> 
				data = response.responseJSON
				btn.text(btnOptionTxt[data.is_active])
				row.find('#siteStatus').text(data.is_active)
			dataType: "JSON"
