json.array!(@petty_cash_items) do |petty_cash_item|
  json.extract! petty_cash_item, :id, :amount, :paid_to, :reason, :date, :bal_carried_forward
  json.url petty_cash_item_url(petty_cash_item, format: :json)
end
