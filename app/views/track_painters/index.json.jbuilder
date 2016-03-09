json.array!(@track_painters) do |track_painter|
  json.extract! track_painter, :id
  json.url track_painter_url(track_painter, format: :json)
end
