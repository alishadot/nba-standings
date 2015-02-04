json.array!(@teams) do |team|
  json.extract! team, :id, :team, :played, :won, :lost
  json.url team_url(team, format: :json)
end
