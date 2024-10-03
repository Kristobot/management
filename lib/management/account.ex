defmodule Management.Account do
  alias String.Tokenizer.Security
  alias Management.Repo
  alias Utils.Token

  alias Management.Account.User
  alias Management.Account.Role
  alias Utils.Security

  #Users

  defp with_roles(include_roles?) do
    case include_roles? do
      "true" -> Repo.all(User) |> Repo.preload(:roles) |> IO.inspect()
      nil -> Repo.all(User)
    end
  end

  defp password_hash(changeset) do
    password = Ecto.Changeset.get_field(changeset, :password)
    changeset
    |> Ecto.Changeset.put_change(:password, Security.encrypt_password(password))
  end

  def list_users(include_roles? \\ nil) do
    try do
      users = include_roles? |> with_roles()
      {:ok, users}

    rescue
      e in [Ecto.QueryError, DBConnection.ConnectionError] ->
        {:error, reason: :database_error, message: Exception.message(e)}
      end
    end

  def create_user(attrs \\ %{}) do
    {:ok, role} = get_role!()
    %User{}
    |> User.changeset(attrs)
    |> password_hash
    |> Ecto.Changeset.put_assoc(:roles, [role])
    |> Repo.insert()
  end

  def get_user!(id), do: {:ok, Repo.get!(User, id)}


  def authenticate_user(email, password) do
    user = Repo.get_by(User, email: email)
    case user do
      user when is_map(user) ->
        if Security.verify_password(password, user.password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
      _-> {:error, :invalid_credentials}
    end
  end

  def get_user_from_token(token) do
    IO.inspect(Token.verify_and_validate(token), label: "Status")
    case Token.verify_and_validate(token) do
      {:ok, %{"id" => id}} -> {:ok, Repo.get!(User, id)}
      _ -> {:error, :invalid_token}
    end
  end

  def generate_token(user) do
    IO.inspect(Token.generate_and_sign(%{"id" => user.id}))
    Token.generate_and_sign(%{"id" => user.id})
  end

  #Roles
    def list_roles(include_users? \\ nil) do
      roles = include_users? |> with_users()
      {:ok, roles}
    end

    defp with_users(include_users?) do
      case include_users? do
        "true" -> Repo.all(Role) |> Repo.preload(:users)
        nil -> Repo.all(Role)
      end
    end

    def get_role!() do
      role = Repo.get_by!(Role, name: "user")
      {:ok, role}
    end
end
