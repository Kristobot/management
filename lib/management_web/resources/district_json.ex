defmodule ManagementWeb.DistrictJSON do
alias Management.Profile.District

  def show(%{district: district}) do
    %{data: data(district)}
  end

  def data([]), do: []

  def data(%District{} = district) do
    %{
      id: district.id,
      name: district.name
    }
  end

  def data(%Ecto.Association.NotLoaded{}), do: []
end
