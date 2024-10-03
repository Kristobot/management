defmodule Management.Repo.Migrations.CreateDistricts do
  use Ecto.Migration

  def change do
    create table(:districts) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
