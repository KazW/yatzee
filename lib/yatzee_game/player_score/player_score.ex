defmodule YatzeeGame.PlayerScore do
  @moduledoc """
  YatzeeGame.PlayerScore is a struct to represent a player's score,
  plus a few functions to perform calculations related to a player's score.
  """

  defstruct ones: nil,
            twos: nil,
            threes: nil,
            fours: nil,
            fives: nil,
            sixes: nil,
            full_house: nil,
            small_straight: nil,
            large_straight: nil,
            three_of_a_kind: nil,
            four_of_a_kind: nil,
            chance: nil,
            yatzee: nil,
            yatzee_bonus: 0

  @type t :: %__MODULE__{
          ones: nil | integer(),
          twos: nil | integer(),
          threes: nil | integer(),
          fours: nil | integer(),
          fives: nil | integer(),
          sixes: nil | integer(),
          full_house: nil | integer(),
          small_straight: nil | integer(),
          large_straight: nil | integer(),
          three_of_a_kind: nil | integer(),
          four_of_a_kind: nil | integer(),
          chance: nil | integer(),
          yatzee: nil | integer(),
          yatzee_bonus: integer()
        }

  alias YatzeeGame.PlayerScore.Impl
  @behaviour Impl

  @impl Impl
  @spec is_valid?(player_score :: t()) :: {:ok, t()} | {:error, atom(), String.t()}
  def is_valid?(player_score = %__MODULE__{}),
    do: impl_module().is_valid?(player_score)

  @impl Impl
  @spec get_round(player_score :: t()) :: non_neg_integer()
  def get_round(player_score = %__MODULE__{}),
    do: impl_module().get_round(player_score)

  @impl Impl
  @spec tally_score(player_score :: t()) :: non_neg_integer()
  def tally_score(player_score = %__MODULE__{}),
    do: impl_module().tally_score(player_score)

  defp impl_module,
    do:
      Application.get_env(
        :yatzee,
        :player_score_impl_module,
        YatzeeGame.PlayerScore.DefaultImpl
      )
end
