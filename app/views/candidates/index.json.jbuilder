json.array!(@candidates) do |candidate|
  json.extract! candidate, :id
  json.url candidate_url(candidate, format: :json)
end
