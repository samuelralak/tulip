json.array!(@invoice_numbers) do |invoice_number|
  json.extract! invoice_number, :id, :invoice_date, :sub_total, :value_added_tax, :total, :site_id
  json.url invoice_number_url(invoice_number, format: :json)
end
