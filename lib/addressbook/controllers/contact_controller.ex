defmodule Addressbook.Processor do
  import Ecto.Query

  alias Addressbook.Repo
  alias Addressbook.Contact

  def save_contact(map_) do
    # make use of changeset to save contact
    IO.inspect(map_)

    contact =
      map_
      |> Map.update!(:suburb_id, &String.to_integer/1)
      |> Map.update!(:user_id, &String.to_integer/1)

    IO.inspect(contact)
    changeset = Contact.changeset(%Contact{}, contact)

    case Repo.insert(changeset) do
      {:ok, result} ->
        {:ok, result}

      {:error, reason} ->
        {:error, reason}
    end
  end

  # get all contacts belonging to a user
  @spec get_contacts(any) :: {:error, %{error: <<_::136>>}} | {:ok, any}
  def get_contacts(user_id) do
    case Repo.all(from(c in Contact, where: c.user_id == ^user_id)) do
      [] ->
        {:error, %{error: "No contacts found"}}

      result ->
        {:ok, result}
    end
  end
end

# %Contact{firstname: map_[:first_name], lastname: map_[:last_name], phone: map_[:phone_number], user_id: String.to_integer(map_[:user_id]), suburb_id: String.to_integer(map_[:suburb_id])}
