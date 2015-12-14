json.array!(@painters) do |painter|
  json.extract! painter, :id, :name, :basic_pay, :daily_wage, :dailyy=_allowance, :employment_type_id
  json.url painter_url(painter, format: :json)
end
