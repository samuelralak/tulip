json.array!(@clients) do |client|
  json.extract! client, :id, :name, :address, :city, :mobile
  json.url client_url(client, format: :json)
end
