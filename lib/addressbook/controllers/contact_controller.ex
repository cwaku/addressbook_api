defmodule Addressbook.Controller.Contact do
  import Ecto.Query

  alias Addressbook.Repo
  alias Addressbook.Schema.Contact

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

  # get all contacts belonging to a user with active_status true and del_status false
  @spec get_contacts(any) :: {:error, %{error: <<_::136>>}} | {:ok, any}
  def get_contacts(user_id) do
    case Repo.all(
           from(c in Contact,
             where: c.user_id == ^user_id and c.active_status == true and c.del_status == false
           )
         ) do
      [] ->
        {:error, %{error: "No contacts found"}}

      contacts ->
        {:ok, contacts}
    end
  end

  # Delete contact by updating active_status to fasle and del_status to true
  # ToDo: Fix this
  def delete_contact(user_id, contact_id) do
    case get_contact(user_id, contact_id) do
      {:ok, contact} ->
        changeset = Contact.changeset(contact, %{active_status: false, del_status: true})

        case Repo.update(changeset) do
          {:ok, result} ->
            {:ok, result}

          {:error, reason} ->
            {:error, reason}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  # get contact. The returned contact will be used in other functions
  def get_contact(user_id, contact_id) do
    case Repo.get_by(Contact, %{
           id: String.to_integer(contact_id),
           user_id: String.to_integer(user_id)
         }) do
      nil ->
        {:error, %{error: "Contact not found"}}

      contact ->
        {:ok, contact}
    end
  end

  # update contact. should update the contact's active_status and del_status to true respectively. After, it should create a new contact with the current map
  def update_contact(user_id, contact_id, map_) do
    case get_contact(user_id, contact_id) do
      {:ok, contact} ->
        changeset = Contact.changeset(contact, %{active_status: false, del_status: true})

        case Repo.update(changeset) do
          {:ok, _result} ->
            # create a new contact with the save_contact function
            case save_contact(map_) do
              {:ok, result} ->
                {:ok, result}

              {:error, reason} ->
                {:error, reason}
            end

          {:error, reason} ->
            {:error, reason}
        end
    end
  end
end
