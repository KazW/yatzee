defmodule Yatzee.Repo do
  use Ecto.Repo,
    otp_app: :yatzee,
    adapter: Ecto.Adapters.Postgres
end
