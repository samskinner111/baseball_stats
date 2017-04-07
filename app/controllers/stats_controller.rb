class StatsController < ApplicationController
  def index
############### Batting Averages
    query1 = Batting.where("at_bats > 200 AND year = 2009 OR year = 2010")
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

    hr, rbi, bat_avg = [], [], []
    query3.each do |record|
      hr << record.home_runs
      rbi << record.rbi
      bat_avg << [record.player_id, record.hits.to_f/record.at_bats.to_f]
    end
    @max_hr = hr.max_by { |h| h }
    @max_rbi = rbi.max_by { |rbi| rbi }
    @max_ba = bat_avg.max_by { |ba| ba }
    @player_with_max_hr = Batting.where("home_runs = #{@max_hr} ")
    @player_with_max_rbi = Batting.where("rbi = #{@max_rbi} ")
    @player_with_max_ba = bat_avg

###############
  end
end
