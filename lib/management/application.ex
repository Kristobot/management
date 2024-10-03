defmodule Management.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ManagementWeb.Telemetry,
      Management.Repo,
      {DNSCluster, query: Application.get_env(:management, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Management.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Management.Finch},
      # Start a worker by calling: Management.Worker.start_link(arg)
      # {Management.Worker, arg},
      # Start to serve requests, typically the last entry
      ManagementWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Management.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ManagementWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
