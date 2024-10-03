defmodule Management.Profile.District do
  use Ecto.Schema
  import Ecto.Changeset

  schema "districts" do
    field :name, :string

    has_many :people, Management.Profile.Person
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(district, attrs) do
    district
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
