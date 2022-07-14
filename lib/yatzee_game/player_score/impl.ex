defmodule YatzeeGame.PlayerScore.Impl do
  @moduledoc false

  @callback is_valid?(player_score :: YatzeeGame.PlayerScore.t()) ::
              {:ok, YatzeeGame.PlayerScore.t()} | {:error, atom(), String.t()}
  @callback get_round(player_score :: YatzeeGame.PlayerScore.t()) :: non_neg_integer()
  @callback tally_score(player_score :: YatzeeGame.PlayerScore.t()) :: non_neg_integer()
end
