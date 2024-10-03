defmodule Management.Profile.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field :name, :string
    field :last_name, :string
    field :address, :string
    field :birth_date, :date

    belongs_to :user, Management.Account.User
    belongs_to :district, Management.Profile.District
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name, :last_name, :address, :birth_date, :district_id, :user_id])
    |> validate_required([:name, :last_name, :address, :birth_date, :district_id])
    |> cast_assoc(:user)
    |> cast_assoc(:district)
  end
end
