defmodule Management.Events do
alias Management.Account.User

  def user_count_created(conn, %User{} = user) do
    :telemetry.execute([:management, :user, :created], %{count: 1}, %{user: user, Method: conn.method})
  end

  def failure(error) do
    :telemetry.execute([:management, :user, :failure], %{count: 1}, %{error: error})
  end

  def query_queue_time(conn, queue_time) do
    :telemetry.execute([:management, :query, :queue_time], %{duration: queue_time}, %{Route: conn.request_path})
  end

end
