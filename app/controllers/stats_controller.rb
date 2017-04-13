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
    @stat = 100*(@jointquery[1]-1)
    @player1 = Player.where("player_id = '#{@jointquery[0]}' ")

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
    @player_data, @trial = [], []
    @player_slugging_percents = player_slugging_percent(query2)
    @player_slugging_percents.each do |player|
      @trial << Player.where("player_id = '#{player[0]}' ")
      @player_data << player[1]
    end
###############

############### Triple Crown Winner: home runs, batting avg, rbi
    query3 = Batting.where("league = 'AL' AND year = 2012 AND at_bats > 400 ")

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

    @player_with_best_ba = top_batting_average(query3)
    #find_tcw
###############


    begin
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
      @tcw = tcw
      unless @tcw == []
        @tcw = Player.where("player_id = '#{tcw.first.player_id}' ")
      end
      @tcw
    end

  end

  private

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

end
