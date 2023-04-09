defmodule Addressbook.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contacts" do
    field(:firstname, :string)
    field(:lastname, :string)
    field(:phone, :string)
    field(:remarks, :string)
    field(:del_status, :boolean, default: false)
    field(:active_status, :boolean, default: true)
    field(:inserted_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    field(:created_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    # field(:updated_at, :naive_datetime)
    # set datetime to naive_datetime with default value
    # field(:updated_at, :naive_datetime, default: NaiveDateTime.utc_now())
    # add datetime to updated_at without the timezone
    field(:updated_at, :naive_datetime, default: NaiveDateTime.local_now)

    belongs_to(:user, Addressbook.User)
    belongs_to(:suburb, Addressbook.Suburb)
  end

  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:firstname, :lastname, :phone, :user_id, :suburb_id])
    |> validate_required([:firstname, :lastname, :phone, :user_id, :suburb_id])
    |> validate_length(:firstname, min: 2, max: 50)
    |> validate_length(:lastname, min: 2, max: 50)
    |> validate_length(:phone, min: 10, max: 10)
    |> validate_format(:phone, ~r/^[0-9]+$/)
    |> validate_number(:user_id, greater_than: 0)
    |> validate_number(:suburb_id, greater_than: 0)
    |> unique_constraint(:phone)
  end
end
