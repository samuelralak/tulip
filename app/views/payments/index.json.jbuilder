json.array!(@payments) do |payment|
  json.extract! payment, :id, :from, :to, :reason, :amount, :payment_type_id
  json.url payment_url(payment, format: :json)
end
