json.array!(@holidays) do |holiday|
  json.extract! holiday, :id, :date, :name, :comments
  json.url holiday_url(holiday, format: :json)
end
