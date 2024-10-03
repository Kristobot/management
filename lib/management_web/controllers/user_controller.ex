defmodule ManagementWeb.UserController do
  use ManagementWeb, :controller

  alias Management.Account

  def create(conn, %{"user" => user_params}) do
    case Account.create_user(user_params) do
      {:ok, user} ->
        conn
        |> render(:show, user: user)
    end
  end

  def index(conn, params) do
    include_roles = params["include_roles"]
    case Account.list_users(include_roles) do
      {:ok, users} ->
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
