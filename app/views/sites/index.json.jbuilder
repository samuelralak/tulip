json.array!(@sites) do |site|
  json.extract! site, :id, :name, :head, :address, :notes
  json.url site_url(site, format: :json)
end
