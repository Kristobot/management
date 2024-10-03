defmodule ManagementWeb.Authentication do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_token(conn) do
      {:error, :unauthorized} -> conn |> send_resp(401, "Unauthorized") |> halt()
      {:ok, token} ->
        case Management.Account.get_user_from_token(token) do
          {:ok, user} -> assign(conn, :current_user, user)
          {:error, :invalid_token} -> conn |> send_resp(401, "Unauthorized") |> halt()
        end
    end
  end

  defp get_token(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] -> {:ok, token}
      _ -> {:error, :unauthorized}
    end
  end
end
