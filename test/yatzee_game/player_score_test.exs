defmodule YatzeeGame.PlayerScoreTest do
  use ExUnit.Case, async: true
  @module YatzeeGame.PlayerScore
  doctest @module

  @perfect_score_value 1575
  @perfect_score %YatzeeGame.PlayerScore{
    ones: 5,
    twos: 10,
    threes: 15,
    fours: 20,
    fives: 25,
    sixes: 30,
    full_house: 25,
    small_straight: 30,
    large_straight: 40,
    three_of_a_kind: 30,
    four_of_a_kind: 30,
    chance: 30,
    yatzee: 50,
    yatzee_bonus: 12
  }

  @average_score_value 267
  @average_score %YatzeeGame.PlayerScore{
    ones: 2,
    twos: 6,
    threes: 9,
    fours: 12,
    fives: 20,
    sixes: 24,
    full_house: 25,
    small_straight: 30,
    large_straight: 40,
    three_of_a_kind: 23,
    four_of_a_kind: 23,
    chance: 18,
    yatzee: 0,
    yatzee_bonus: 0
  }

  test "blank/new scores should be valid" do
    assert @module.is_valid?(%@module{})
  end

  test "perfect score should be valid" do
    assert {:ok, _ = %@module{}} = @module.is_valid?(@perfect_score)
  end

  test "average score should be valid" do
    assert {:ok, _ = %@module{}} = @module.is_valid?(@average_score)
  end

  test "should give the correct score for a blank/new score" do
    assert @module.tally_score(%@module{}) == 0
  end

  test "should give the correct score for a perfect score" do
    assert @module.tally_score(@perfect_score) == @perfect_score_value
  end

  test "should give the correct score for a average score" do
    assert @module.tally_score(@average_score) == @average_score_value
  end
end
