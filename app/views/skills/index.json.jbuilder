json.array!(@skills) do |skill|
  json.extract! skill, :id, :name, :code
  json.url skill_url(skill, format: :json)
end
