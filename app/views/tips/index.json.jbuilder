json.array!(@tips) do |tip|
  json.extract! tip, :id, :link, :—-skip-stylesheets
  json.url tip_url(tip, format: :json)
end
