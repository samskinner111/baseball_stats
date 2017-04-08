class StatsController < ApplicationController
  def index
############### Batting Averages
    query09 = Batting.where("at_bats > 200 AND year = 2009")
    query10 = Batting.where("at_bats > 200 AND year = 2010")

    joint = []
    query09.each do |p|
      name = p.player_id
      query10.each do |q|
        if q.player_id == name
          joint << q 
          joint << p
        end
      end
    end
    list = []
    joint.each_slice(2) do | p09, p10 |
      ba09 = p09.hits.to_f/p09.at_bats.to_f
      ba10 = p10.hits.to_f/p10.at_bats.to_f
      improvement = ba09/ba10
      list << [p09.player_id, improvement]
    end
    most_improved = ['pup', 0]
    list.each do |l|
      if most_improved[1] < l[1]
        most_improved = l
      else
        most_improved
      end
    end
    @jointquery = most_improved


 ###############

############### Slugging Percentages
    query2 = Batting.where("team = 'OAK' AND year = 2007 AND home_runs != 0 AND rbi != 0")
    def player_slugging_percent(query)
      player_slugging_percent = []
      query.each do | record |
        slugging_percent = 100*(((record.hits - record.doubles - record.triples - record.home_runs)
                             + (2*record.doubles) + (3*record.triples) 
                             + (4*record.home_runs)).to_f/record.at_bats.to_f)
        player_slugging_percent << [record.player_id, slugging_percent]
      end
      player_slugging_percent
    end
    @player_slugging_percents = player_slugging_percent(query2)
###############

############### Triple Crown Winner: home runs, batting avg, rbi
    query3 = Batting.where("league = 'AL' AND year = 2012 AND at_bats > 400 ")
    @battings = query3

    begin
      hr, rbi = [], []
      query3.each do |record|
        hr << record.home_runs
        rbi << record.rbi
      end
      max_hr = hr.max_by { |h| h }
      @player_with_max_hr = Batting.where("home_runs = #{max_hr}")

      max_rbi = rbi.max_by { |rbi| rbi }
      @player_with_max_rbi = Batting.where("rbi = #{max_rbi}")
    end

    bat_avg = ['o', 0]
    query3.each do |record|
      avg = record.hits.to_f/record.at_bats.to_f
      if avg > bat_avg[1]
        bat_avg = [record.player_id, avg]
      else
        bat_avg
      end
      bat_avg
    end
    @player_with_best_ba = bat_avg
    @player_name = Player.where("player_id = '#{bat_avg[0]}' ")
###############
  end
end
