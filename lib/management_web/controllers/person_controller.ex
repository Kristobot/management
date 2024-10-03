defmodule ManagementWeb.PersonController do
  use ManagementWeb, :controller
  alias Management.Profile

  def create(conn, %{"person" => person_params}) do
    user = conn.assigns.current_user

    case Profile.create_person(person_params, user) do
      {:ok, person} ->
        conn
        |> render(:show, person: person)
    end
  end
end
