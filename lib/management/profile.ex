defmodule Management.Profile do
  alias Management.Repo
  alias Management.Profile.District
  alias Management.Profile.Person

  #Districts
  def list_districts(), do: {:ok, Repo.all(District)}

  #People

  def create_person(person_params, user) do
    %Person{}
    |> Person.changeset(person_params)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> set_district_to_person()
    |> Repo.insert()
  end

  defp set_district_to_person(changeset) do
    district_id = Ecto.Changeset.get_field(changeset, :district_id)
    district = get_district!(district_id)

    Ecto.Changeset.put_assoc(changeset, :district, elem(district, 1))
  end

  def get_district!(district_id), do: {:ok, Repo.get_by!(District, id: district_id)}

end
