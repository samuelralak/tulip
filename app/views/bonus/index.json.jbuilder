json.array!(@bonus) do |bonu|
  json.extract! bonu, :id, :amount, :date_applicable, :painter_id
  json.url bonu_url(bonu, format: :json)
end
