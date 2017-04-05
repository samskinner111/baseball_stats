require 'test_helper'

class BattingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @batting = battings(:one)
  end

  test "should get index" do
    get battings_url
    assert_response :success
  end

  test "should get new" do
    get new_batting_url
    assert_response :success
  end

  test "should create batting" do
    assert_difference('Batting.count') do
      post battings_url, params: { batting: { CS: @batting.CS, G: @batting.G, R: @batting.R, SB: @batting.SB, at_bats: @batting.at_bats, doubles: @batting.doubles, hits: @batting.hits, home_runs: @batting.home_runs, league: @batting.league, player_id: @batting.player_id, rbi: @batting.rbi, team: @batting.team, triples: @batting.triples, year: @batting.year } }
    end

    assert_redirected_to batting_url(Batting.last)
  end

  test "should show batting" do
    get batting_url(@batting)
    assert_response :success
  end

  test "should get edit" do
    get edit_batting_url(@batting)
    assert_response :success
  end

  test "should update batting" do
    patch batting_url(@batting), params: { batting: { CS: @batting.CS, G: @batting.G, R: @batting.R, SB: @batting.SB, at_bats: @batting.at_bats, doubles: @batting.doubles, hits: @batting.hits, home_runs: @batting.home_runs, league: @batting.league, player_id: @batting.player_id, rbi: @batting.rbi, team: @batting.team, triples: @batting.triples, year: @batting.year } }
    assert_redirected_to batting_url(@batting)
  end

  test "should destroy batting" do
    assert_difference('Batting.count', -1) do
      delete batting_url(@batting)
    end

    assert_redirected_to battings_url
  end
end
