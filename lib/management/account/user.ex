defmodule Management.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :password, :string
    field :email, :string

    has_one :person, Management.Profile.Person
    many_to_many :roles, Management.Account.Role, join_through: "users_roles"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> cast_assoc(:roles)
  end

  def update_user(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> cast_assoc(:roles)
  end
end
