class BattingsController < ApplicationController
  before_action :set_batting, only: [:show, :edit, :update, :destroy]

  # GET /battings
  # GET /battings.json
  def index
    query1 = Batting.where("team = 'OAK' AND year = 2007 AND home_runs != 0 AND rbi != 0")
    query2 = Batting.where("at_bats > 200 AND year = 2009 OR year = 2010")
    query3 = Batting.where("league = 'AL' ")
    @battings = query1
    hr, rbi, bat_avg = [], [], []
    query1.each do |record|
      hr << record.home_runs
      rbi << record.rbi
      bat_avg << record.hits.to_f/record.at_bats.to_f
    end
    @max_hr = hr.max_by { |h| h }
    @max_rbi = rbi.max_by { |rbi| rbi }
    @max_ba = bat_avg.max_by { |ba| ba }
  end

  def show
  end

  def new
    @batting = Batting.new
  end

  def edit
  end

  def create
    @batting = Batting.new(batting_params)

    respond_to do |format|
      if @batting.save
        format.html { redirect_to @batting, notice: 'Batting was successfully created.' }
        format.json { render :show, status: :created, location: @batting }
      else
        format.html { render :new }
        format.json { render json: @batting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @batting.update(batting_params)
        format.html { redirect_to @batting, notice: 'Batting was successfully updated.' }
        format.json { render :show, status: :ok, location: @batting }
      else
        format.html { render :edit }
        format.json { render json: @batting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @batting.destroy
    respond_to do |format|
      format.html { redirect_to battings_url, notice: 'Batting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batting
      @batting = Batting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def batting_params
      params.require(:batting).permit(:player_id, :year, :league, :team, :G, :at_bats, :R, :hits, :doubles, :triples, :home_runs, :rbi, :SB, :CS)
    end
end
