defmodule Addressbook.City do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cities" do
    field(:name, :string)
    # add remarks
    field(:remarks, :string)
    # field(:del_status, :boolean, default: false)
    # field(:active_status, :boolean, default: true)
    # field(:inserted_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    field(:created_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    field(:updated_at, :naive_datetime, default: NaiveDateTime.local_now)

    belongs_to(:region, Addressbook.Region)
    belongs_to(:user, Addressbook.User)
    has_many(:suburbs, Addressbook.Suburb)
    # add references to user
    has_many(:users, Addressbook.User)
  end

  def changeset(city, attrs) do
    city
    |> cast(attrs, [:name, :region_id])
    |> validate_required([:name, :region_id])
    |> validate_length(:name, min: 2, max: 50)
    |> unique_constraint(:name)
  end
end
