defmodule ManagementWeb.UserController do
  use ManagementWeb, :controller
  alias Management.Events

  alias Management.Account

  def create(conn, %{"user" => user_params}) do
    case Account.create_user(user_params) do
      {:ok, user} ->
        Events.user_count_created(conn, user)
        conn
        |> render(:show, user: user)
      {:error, response} ->
        Events.failure(response.errors)
        conn
        |> put_status(:unprocessable_entity)
        |> render(:error, error: response.errors)
    end
  end

  def index(conn, params) do
    start = System.monotonic_time()
    include_roles = params["include_roles"]
    case Account.list_users(include_roles) do
      {:ok, users} ->
        duration = System.monotonic_time() - start
        Events.query_queue_time(conn, duration)
        conn
        |> render(:index, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    case Account.get_user!(id) do
      {:ok, user} ->
        conn
        |> render(:show, user: user)
    end
  end

  def profile(conn, _params) do
    user = conn.assigns.current_user
    conn
    |> render(:show, user: user)
  end
end
