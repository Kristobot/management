defmodule Management.Profile.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field :name, :string
    field :last_name, :string
    field :address, :string
    field :birth_date, :date

    belongs_to :person, Management.Profile.Person
    belongs_to :district, Management.Profile.District
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name, :last_name])
    |> validate_required([:name, :last_name])
  end
end
