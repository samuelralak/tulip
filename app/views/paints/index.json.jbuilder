json.array!(@paints) do |paint|
  json.extract! paint, :id, :month, :year, :amount, :site_id
  json.url paint_url(paint, format: :json)
end
