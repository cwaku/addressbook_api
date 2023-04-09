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

  # Delete contact by updating active_status to fasle and del_status to true
  # ToDo: Fix this
  def delete_contact(user_id, contact_id) do
    contact = Repo.get_by(Contact, %{id: String.to_integer(contact_id), user_id: String.to_integer(user_id)})

    case contact do
      nil ->
        {:error, %{error: "Contact not found"}}

      contact ->
        changeset = Contact.changeset(contact, %{active_status: false, del_status: true})
        IO.inspect(changeset, label: "Changeset:")

        case Repo.update(changeset) do
          {:ok, result} ->
            IO.inspect(result, label: "Result:")
            updated_contact = Repo.get(Contact, contact_id)
            IO.inspect(updated_contact, label: "Updated Contact:")
            {:ok, result}

          {:error, reason} ->
            IO.inspect(reason, label: "Error:")
            {:error, reason}
        end
    end
  end


end


# %Contact{firstname: map_[:first_name], lastname: map_[:last_name], phone: map_[:phone_number], user_id: String.to_integer(map_[:user_id]), suburb_id: String.to_integer(map_[:suburb_id])}
