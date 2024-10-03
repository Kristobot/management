defmodule Management.Repo.Migrations.AlterTableUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :person_id, references(:people, on_delete: :delete_all)
    end
  end
end
