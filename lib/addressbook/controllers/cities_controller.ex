defmodule Addressbook.CitiesController do

  alias Addressbook.Repo
  alias Addressbook.City

  def get_cities do
    case Repo.all(City) do
      [] ->
        {:error, %{error: "No cities found"}}

      cities ->
        {:ok, cities}
    end
  end
end
