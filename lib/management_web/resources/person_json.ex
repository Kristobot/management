defmodule ManagementWeb.PersonJSON do
  alias ManagementWeb.DistrictJSON
  alias Management.Profile.Person

  def show(%{person: person}) do
    %{data: data(person)}
  end

  def index(%{people: people}) do
    %{data: Enum.map(people, &data/1)}
  end


  def data(%Person{} = person) do
    %{
      id: person.id,
      name: person.name,
      last_name: person.last_name,
      address: person.address,
      birth_date: person.birth_date,
      district: DistrictJSON.data(person.district)
    }
  end

  def data([]), do: []
end
