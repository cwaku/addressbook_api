defmodule Addressbook.Controller.Region do
  alias Addressbook.Repo
  alias Addressbook.Schema.Region

  def get_regions do
    case Repo.all(Region) do
      [] ->
        {:error, %{error: "No regions found"}}

      regions ->
        {:ok, regions}
    end
  end
end
