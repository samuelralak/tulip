json.array!(@deductions) do |deduction|
  json.extract! deduction, :id, :date, :reason, :amount
  json.url deduction_url(deduction, format: :json)
end
