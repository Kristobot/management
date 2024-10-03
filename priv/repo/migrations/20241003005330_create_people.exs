defmodule Management.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :name, :string
      add :last_name, :string
      add :address, :string
      add :birth_date, :date
      add :district_id, references(:districts, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
      timestamps(type: :utc_datetime)
    end
  end
end
