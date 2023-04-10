defmodule Addressbook.RegionsController do
  import Ecto.Query
  alias Addressbook.Repo
  alias Addressbook.Region

  def get_regions do
    case Repo.all(Region) do
      [] ->
        {:error, %{error: "No regions found"}}

      regions ->
        {:ok, regions}
    end
  end
end
