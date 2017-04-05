json.extract! batting, :id, :player_id, :year, :league, :team, :G, :at_bats, :R, :hits, :doubles, :triples, :home_runs, :rbi, :SB, :CS, :created_at, :updated_at
json.url batting_url(batting, format: :json)
