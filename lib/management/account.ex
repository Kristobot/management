defmodule Management.Account do
  alias String.Tokenizer.Security
  alias Management.Repo

  alias Management.Account.User
  alias Management.Account.Role
  alias Utils.Security

  defp with_users(true), do: Repo.all(Role) |> Repo.preload([users: :person])

  defp with_users(false), do: Repo.all(Role)

  defp with_roles(true), do: Repo.all(User) |> Repo.preload(:roles)

  defp with_roles(false), do: Repo.all(User)

  defp password_hash(attrs) do
    attrs
    |> Map.put(:password,Security.encrypt_password(attrs.password))
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> password_hash
    |> Repo.insert()
  end

  def list_users(include_users? \\ false) do
    include_users?
    |> with_users
  end

  def list_roles(include_roles? \\ false) do
    include_roles?
    |> with_roles
  end

end
