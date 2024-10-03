defmodule ManagementWeb.SessionJSON do

  alias ManagementWeb.ErrorJSON

  def show(%{user: user, token: token}) do
    %{
      user: %{id: user.id},
      token: token
    }
  end

  def error(%{reason: reason}) do
    ErrorJSON.render("error.json", %{error: reason})
  end
end
