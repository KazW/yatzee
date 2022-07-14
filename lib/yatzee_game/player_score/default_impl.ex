defmodule YatzeeGame.PlayerScore.DefaultImpl do
  @moduledoc false
  alias YatzeeGame.PlayerScore
  alias YatzeeGame.PlayerScore.Impl

  @behaviour Impl
  @type player_score :: PlayerScore.t()

  @top_values [:ones, :twos, :threes, :fours, :fives, :sixes]
  @bottom_values [
    :full_house,
    :small_straight,
    :large_straight,
    :three_of_a_kind,
    :four_of_a_kind,
    :chance,
    :yatzee
  ]

  @ones_values [nil | [0 | Enum.to_list(1..5) |> Enum.map(fn i -> 1 * i end)]]
  @twos_values [nil | [0 | Enum.to_list(1..5) |> Enum.map(fn i -> 2 * i end)]]
  @threes_values [nil | [0 | Enum.to_list(1..5) |> Enum.map(fn i -> 3 * i end)]]
  @fours_values [nil | [0 | Enum.to_list(1..5) |> Enum.map(fn i -> 4 * i end)]]
  @fives_values [nil | [0 | Enum.to_list(1..5) |> Enum.map(fn i -> 5 * i end)]]
  @sixes_values [nil | [0 | Enum.to_list(1..5) |> Enum.map(fn i -> 6 * i end)]]
  @summed_values [nil | [0 | Enum.to_list(5..30)]]
  @full_house_values [nil, 0, 25]
  @small_straight_values [nil, 0, 30]
  @large_straight_values [nil, 0, 40]
  @yatzee_values [nil, 0, 50]
  @yatzee_bonus_values 0..12

  @impl Impl
  @spec is_valid?(player_score :: player_score()) ::
          {:ok, player_score()} | {:error, atom(), String.t()}
  def is_valid?(player_score = %PlayerScore{}),
    do:
      {:ok, player_score}
      |> check_allowed_values(:ones, @ones_values)
      |> check_allowed_values(:twos, @twos_values)
      |> check_allowed_values(:threes, @threes_values)
      |> check_allowed_values(:fours, @fours_values)
      |> check_allowed_values(:fives, @fives_values)
      |> check_allowed_values(:sixes, @sixes_values)
      |> check_allowed_values(:full_house, @full_house_values)
      |> check_allowed_values(:small_straight, @small_straight_values)
      |> check_allowed_values(:large_straight, @large_straight_values)
      |> check_allowed_values(:three_of_a_kind, @summed_values)
      |> check_allowed_values(:four_of_a_kind, @summed_values)
      |> check_allowed_values(:chance, @summed_values)
      |> check_allowed_values(:yatzee, @yatzee_values)
      |> check_allowed_values(:yatzee_bonus, @yatzee_bonus_values)
      |> check_bonus_vs_rounds

  defp check_allowed_values({:ok, player_score}, key, allowed_values) do
    case Map.fetch!(player_score, key) in allowed_values do
      true -> {:ok, player_score}
      false -> {:error, key, "invalid value"}
    end
  end

  defp check_allowed_values(pass, _key, _allowed_values),
    do: pass

  defp check_bonus_vs_rounds({:ok, %PlayerScore{yatzee_bonus: bonus, yatzee: yatzee}})
       when (is_nil(yatzee) or yatzee == 0) and bonus > 0,
       do: {:error, :yatzee_bonus, "set before yatzee"}

  defp check_bonus_vs_rounds({:ok, player_score = %PlayerScore{yatzee_bonus: bonus}})
       when bonus > 0 do
    case bonus <= get_round(player_score) - 1 do
      true -> {:ok, player_score}
      false -> {:error, :yatzee_bonus, "greater than current round"}
    end
  end

  defp check_bonus_vs_rounds(pass),
    do: pass

  @impl Impl
  @spec get_round(player_score :: player_score()) :: non_neg_integer()
  def get_round(player_score),
    do:
      player_score
      |> Map.from_struct()
      |> Map.filter(fn {key, value} -> key != :yatzee_bonus and not is_nil(value) end)
      |> map_size()

  @impl Impl
  @spec tally_score(player_score :: player_score()) :: non_neg_integer()
  def tally_score(player_score = %PlayerScore{}),
    do:
      player_score
      |> is_valid?
      |> add_top_total
      |> add_top_bonus
      |> add_bottom_total
      |> add_yatzee_bonus

  defp add_top_total({:error, _key, _error}), do: 0

  defp add_top_total({:ok, player_score}),
    do: {
      :ok,
      player_score,
      filtered_sum(player_score, @top_values)
    }

  defp add_top_bonus({:ok, player_score, current_score})
       when is_integer(current_score) and current_score >= 63,
       do: {:ok, player_score, current_score + 35}

  defp add_top_bonus(pass), do: pass

  defp add_bottom_total({:ok, player_score, current_score}),
    do: {
      :ok,
      player_score,
      current_score + filtered_sum(player_score, @bottom_values)
    }

  defp add_bottom_total(pass), do: pass

  defp add_yatzee_bonus({:ok, %PlayerScore{yatzee_bonus: bonus}, current_score})
       when is_integer(bonus) and bonus > 0,
       do: current_score + 100 * bonus

  defp add_yatzee_bonus({:ok, _player_score, current_score}), do: current_score
  defp add_yatzee_bonus(pass), do: pass

  defp filtered_sum(player_score, filter_keys),
    do:
      player_score
      |> Map.from_struct()
      |> Map.filter(fn {key, value} -> is_integer(value) and key in filter_keys end)
      |> Map.values()
      |> Enum.sum()
end
