defmodule Addressbook.Schema.Region do
  use Ecto.Schema
  import Ecto.Changeset

  schema "regions" do
    field(:name, :string)
    # add remarks
    field(:remarks, :string)
    # field(:del_status, :boolean, default: false)
    # field(:active_status, :boolean, default: true)
    # field(:inserted_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    field(:created_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    field(:updated_at, :naive_datetime, default: NaiveDateTime.local_now)

    has_many(:cities, Addressbook.City)
    has_many(:users, Addressbook.User)
  end

  def changeset(region, attrs) do
    region
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 2, max: 50)
    |> unique_constraint(:name)
  end
end
