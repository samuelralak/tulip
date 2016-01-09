json.array!(@petty_cashes) do |petty_cash|
  json.extract! petty_cash, :id, :paid_to, :amount, :reason, :date_paid
  json.url petty_cash_url(petty_cash, format: :json)
end
