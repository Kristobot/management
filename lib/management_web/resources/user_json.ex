defmodule ManagementWeb.UserJSON do
  alias Management.Account.User

  def show(%{user: user}) do
    %{data: data(user)}
  end

  def index(%{users: users}) do
    %{data: Enum.map(users, &data/1)}
  end

  def data([]), do: []

  def data(%User{} = user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email
    }
  end

end
