defmodule Management.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :description, :string
      add :metadata, :map
      add :tags, {:array, :string}, default: []

      timestamps(type: :utc_datetime)
    end
  end
end
