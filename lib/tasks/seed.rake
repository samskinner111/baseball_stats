require 'csv'

namespace :db do
  namespace :seed do
    desc "Import Player Dataset"
    task :import_player => :environment do

      filename = File.join(Rails.root, 'db', 'data_files', 'player_data.csv')
      CSV.foreach(filename, :headers => true) do |row|
        puts $. if $. % 10000 == 0
        values = {
          :player_id    => row['player_id'],
          :birth_year   => row['birth_year'],
          :first_name   => row['first_name'],
          :last_name    => row['last_name']

        }
        Player.create(values)
      end
    end

    desc "Import Batting Dataset"
    task :import_batting => :environment do

      filename = File.join(Rails.root, 'db', 'data_files', 'batting_data.csv')
      CSV.foreach(filename, :headers => true) do |row|
        puts $. if $. % 10000 == 0
        values = {
          :player_id    => row['player_id'],
          :year         => row['year'],
          :league       => row['league'],
          :team         => row['team'],
          :G           => row['G'],
          :at_bats      => row['at_bats'],
          :R           => row['R'],
          :hits         => row['hits'],
          :doubles      => row['doubles'],
          :triples      => row['triples'],
          :home_runs    => row['home_runs'],
          :rbi          => row['rbi'],
          :SB           => row['SB'],
          :CS           => row['CS']
        }
        Batting.create(values)
      end
    end
  end
end