defmodule Management.EventHandler do

  alias Management.Repo
  alias Management.Event

  def handle_event([:management, :user, :created], _measurements, metadata, _config) do

    IO.inspect("Hola desde handle event user created", label: "Status")
    user = Map.get(metadata, :user)
    method = Map.get(metadata, :Method)
    Event.changeset(%Event{}, %{name: "User created", description: "User created with method #{method} and user #{user.username}"})
    |> Repo.insert()
  end

  def handle_event([:management, :user, :failure], _measurements, metadata, _config) do
    IO.inspect("Hola desde handle event user failde created", label: "Status")
    error = Map.get(metadata, :error)
    message = convert_to_string(error)
    Repo.insert(%Event{name: "User failed to create", description: "User failed to create with error #{message}"}, metadata: metadata)
  end

  def handle_event([:management, :query, :queue_time], measurements, metadata, _config) do
    duration = Map.get(measurements, :duration)
    route = Map.get(metadata, :Route)
    Repo.insert(%Event{name: "Query queue time", description: "Query queue time #{duration} for route #{route}"}, metadata: metadata)
  end

  defp convert_to_string(error) do
    error
    |> Keyword.keys()
    |> Enum.join(", ")
  end
end
