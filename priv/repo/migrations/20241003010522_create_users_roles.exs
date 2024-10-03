defmodule Management.Repo.Migrations.CreateUsersRoles do
  use Ecto.Migration

  def change do
    create table(:users_roles) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :role_id, references(:roles, on_delete: :delete_all)
    end
  end
end
