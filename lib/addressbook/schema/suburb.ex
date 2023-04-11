defmodule Addressbook.Schema.Suburb do
  use Ecto.Schema
  import Ecto.Changeset

  schema "suburbs" do
    field(:name, :string)
    # field(:del_status, :boolean, default: false)
    # field(:active_status, :boolean, default: true)
    # field(:inserted_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    field(:created_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    field(:updated_at, :naive_datetime, default: NaiveDateTime.local_now())

    belongs_to(:city, Addressbook.City)
    belongs_to(:user, Addressbook.User)
  end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(suburb, attrs) do
    suburb
    |> cast(attrs, [:name, :city_id])
    |> validate_required([:name, :city_id])
    |> validate_length(:name, min: 2, max: 50)
    |> unique_constraint(:name)
  end
end
