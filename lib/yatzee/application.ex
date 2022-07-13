defmodule Yatzee.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Yatzee.Repo,
      # Start the Telemetry supervisor
      YatzeeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Yatzee.PubSub},
      # Start the Endpoint (http/https)
      YatzeeWeb.Endpoint
      # Start a worker by calling: Yatzee.Worker.start_link(arg)
      # {Yatzee.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Yatzee.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    YatzeeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
