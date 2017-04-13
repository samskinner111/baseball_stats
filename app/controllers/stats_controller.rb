class StatsController < ApplicationController
  def index
############### Batting Averages
    query09 = Batting.where("at_bats > 200 AND year = 2009")
    query10 = Batting.where("at_bats > 200 AND year = 2010")

    player_list = find_players_with_two_years_data(query09, query10)
    most_improved = find_most_improved(player_list)

    @mi_player = Player.where("player_id = '#{most_improved[0]}' ")  #find player's name
    @stat = 100*(most_improved[1]-1)  ## convert to percentage
 ###############

############### Slugging Percentages
    query1 = Batting.where("team = 'OAK' AND year = 2007 AND home_runs != 0 AND rbi != 0")

    player_slugging_percents = player_slugging_percent(query1).sort

    @player_percent, @player_name = [], []
    player_slugging_percents.each do |player|
      @player_name << Player.where("player_id = '#{player[0]}' ") #convert player_id to name
      @player_percent << player[1]
    end
###############

############### Triple Crown Winner: home runs, batting avg, rbi
    query_tcw = Batting.where("league = 'AL' AND year = 2012 AND at_bats > 400 ")

    @player_with_max_hr = find_players_with_most_homeruns(query_tcw)
    @player_with_max_rbi = find_players_with_most_rbi(query_tcw)  
    @player_with_best_ba = top_batting_average(query_tcw)
    
    @tcw = find_tcw
###############
  end

  private

  def find_players_with_two_years_data(p09, p10)
    joint = []
    p09.each do |p|
      name = p.player_id
      p10.each do |q|
        if q.player_id == name
          joint << q 
          joint << p
        end
      end
    end
    joint
  end

  def find_most_improved(player_list)
    candidates = []
    player_list.each_slice(2) do | p09, p10 |
      ba09 = p09.hits.to_f/p09.at_bats.to_f
      ba10 = p10.hits.to_f/p10.at_bats.to_f
      improvement = ba09/ba10
      candidates << [p09.player_id, improvement]
    end
    most_improved = ['', 0]
    candidates.each do |c|
      if most_improved[1] < c[1]
        most_improved = c
      else
        most_improved
      end
    end
    most_improved
  end

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

  def top_batting_average(players)
    bat_avg = ['', 0]
    players.each do |data|
      avg = data.hits.to_f/data.at_bats.to_f
      if avg > bat_avg[1]
        bat_avg = [data.player_id, avg]
      else
        bat_avg
      end
    end
    bat_avg
  end

  def find_players_with_most_homeruns(query)
    hr = []
    query.each do |record|
      hr << record.home_runs
    end
    max_hr = hr.max_by { |h| h }
    player_with_max_hr = Batting.where("home_runs = #{max_hr}")
  end

  def find_players_with_most_rbi(query)
    rbi = []
    query.each do |record|
      rbi << record.rbi
    end
    max_rbi = rbi.max_by { |rbi| rbi }
    @player_with_max_rbi = Batting.where("rbi = #{max_rbi}")
  end

  def find_tcw
    tcw = []
    @player_with_max_hr.each do |player|
      if player.player_id == @player_with_best_ba[0]
        tcw << player
      end
    end
    if tcw != []
      tcw = []
      @player_with_max_rbi.each do |player|
        if player.player_id == @player_with_best_ba[0]
          tcw << player
        end
      end
    end
    unless tcw == []
      tcw = Player.where("player_id = '#{tcw.first.player_id}' ")
    end
    tcw
  end

end