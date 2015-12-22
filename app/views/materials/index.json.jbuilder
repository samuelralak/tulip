json.array!(@materials) do |material|
  json.extract! material, :id, :painter_id, :date, :total_spent, :reason
  json.url material_url(material, format: :json)
end
