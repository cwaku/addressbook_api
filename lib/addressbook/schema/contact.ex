defmodule Addressbook.Contact do
  use Ecto.Schema
  # alias Addressbook.{Processor, Repo}

  import Ecto.Changeset

  schema "contacts" do
    field :firstname, :string
    field :lastname, :string
    field :phone, :string
    field :remarks, :string
    field :del_status, :boolean, default: false
    field :active_status, :boolean, default: true
    field :inserted_at, :utc_datetime, default: DateTime.utc_now |> DateTime.truncate(:second)
    field :created_at, :utc_datetime, default: DateTime.utc_now |> DateTime.truncate(:second)
    field :updated_at, :utc_datetime, default: DateTime.utc_now |> DateTime.truncate(:second)

    belongs_to :user, Addressbook.User
    belongs_to :suburb, Addressbook.Suburb

    # add unique phone
    # unique_constraint :phone

    # timestamps()
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
    # |> Ecto.Changeset.validate_unique(:phone, name: :unique_contact_phone, message: "Phone number already exists")
  end
end


# curl --location 'http://10.136.168.7:3049/contact' \
# --header 'Content-Type: application/json' \
# --data '{
#     "firstname": "Post 1",
#     "lastname": "Post 1",
#     "user_id": 1,
#     "suburb_id": 1,
#     "phone": "1234567890"
# }'
