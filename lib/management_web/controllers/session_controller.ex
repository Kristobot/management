defmodule ManagementWeb.SessionController do
  use ManagementWeb, :controller
  alias Management.Account

  def authenticate(conn, %{"email" => email, "password" => password}) do
    case Account.authenticate_user(email, password) do
      {:ok, user} ->
        {:ok, token, _claims} = Account.generate_token(user)
        conn
        |> put_status(:created)
        |> render("show.json", %{user: user, token: token})

      {:error, :invalid_credentials} ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", error: "Invalid email or password")
    end
  end
end
