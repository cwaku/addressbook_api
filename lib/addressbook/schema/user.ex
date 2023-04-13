defmodule Addressbook.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:firstname, :string)
    field(:lastname, :string)
    field(:email, :string)
    field(:phone, :string)
    field(:del_status, :boolean, default: false)
    field(:active_status, :boolean, default: true)
    # field(:inserted_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    field(:created_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    # field(:updated_at, :naive_datetime)
    # set datetime to naive_datetime with default value
    # field(:updated_at, :naive_datetime, default: NaiveDateTime.utc_now())
    # add datetime to updated_at without the timezone
    field(:updated_at, :naive_datetime, default: NaiveDateTime.local_now)

    has_many(:contacts, Addressbook.Schema.Contact)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :phone])
    |> validate_required([:firstname, :lastname, :phone])
    |> validate_length(:firstname, min: 2, max: 50)
    |> validate_length(:lastname, min: 2, max: 50)
    |> validate_length(:phone, min: 10, max: 10)
    |> validate_format(:phone, ~r/^[0-9]+$/)
    |> unique_constraint(:phone)
  end
end
