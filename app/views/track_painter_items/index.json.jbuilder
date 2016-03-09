json.array!(@track_painter_items) do |track_painter_item|
  json.extract! track_painter_item, :id, :site_id, :date_attended, :daily_wage, :track_painter_id, :daily_allowance
  json.url track_painter_item_url(track_painter_item, format: :json)
end
