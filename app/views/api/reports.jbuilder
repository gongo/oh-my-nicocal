json.reports do
  json.array!(@reports) do |report|
    json.extract! report, :id, :date
    json.name report.mood.name
    json.score report.mood.score
  end
end
