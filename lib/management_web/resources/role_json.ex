defmodule ManagementWeb.RoleJSON do
  alias Management.Account.Role
  def show(%{role: role}) do
    %{data: data(role)}
  end

  def index(%{roles: roles}) do
    %{data: Enum.map(roles, &data/1)}
  end


  def data([]), do: []

  def data(%Role{} = role) do
    %{
      id: role.id,
      name: role.name
    }
  end

  def data(%Ecto.Association.NotLoaded{}), do: []
end
