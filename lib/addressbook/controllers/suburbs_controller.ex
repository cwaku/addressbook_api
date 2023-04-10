defmodule Addressbook.SuburbsController do

  alias Addressbook.Repo
  alias Addressbook.Suburb

  def get_suburbs do
    case Repo.all(Suburb) do
      [] ->
        {:error, %{error: "No suburbs found"}}

      suburbs ->
        {:ok, suburbs}
    end
  end
end
