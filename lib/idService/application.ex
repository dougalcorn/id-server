defmodule IdService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      IdService.Repo,
      # Start the Telemetry supervisor
      IdServiceWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: IdService.PubSub},
      # Start the Endpoint (http/https)
      IdServiceWeb.Endpoint,
      # Start a worker by calling: IdService.Worker.start_link(arg)
      # {IdService.Worker, arg}

      IdService.AccountsServer
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: IdService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    IdServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
