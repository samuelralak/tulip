jQuery -> 
	$("input#invoice_amount").on 'keyup', (event) ->
		calculateSubtotal(this)
	$("input#invoice_value_added_tax").on 'keyup', (event) ->
		calculateTotal(this)

	calculateSubtotal = (src) -> 
		sum = 0.0
		form = $(src).closest('form')
		amount = form.find("input#invoice_amount").val()
		subTotal = (amount/1.16).toFixed(2)
		valueAddedTax = ((amount/1.16) * 0.16).toFixed(2)
		total = subTotal + valueAddedTax
		form.find("input#invoice_sub_total").val(subTotal)
		form.find("input#invoice_value_added_tax").val(valueAddedTax)
		form.find("input#invoice_total").val(amount)


	calculateTotal = (src) -> 
		form = $(src).closest('form')
		subTotal = form.find("input#invoice_sub_total").val()
		vat = form.find("input#invoice_value_added_tax").val()
		total = parseFloat(subTotal) + parseFloat(vat)
		form.find("input#invoice_total").val(total)
