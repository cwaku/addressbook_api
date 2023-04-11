# Addressbook

A simple Elixir API for managing an addressbook. It allows all the CRUD operations for managing contacts.

## Endpoints


##### GET `/regions`

Returns a list of all regions.

##### GET `/cities`

Returns a list of all cities.

##### GET `/suburbs`

Returns a list of all suburbs.


##### GET `/contacts/:user_id`

Returns a list of all contacts that belongs to the user.

##### POST `/contact`

Creates a new contact. This endpoint requires a JSON
body with the following structure:

```json
{
  "firstname": "Elixir",
  "lastname": "Dude",
  "user_id": "1",
  "suburb_id": "1",
  "phone": "1234567890"
}
```


##### PUT `/contact/:user_id/:contact_id`

Updates a contact.
This endpoint requires a JSON body with the following structure:

```json
{
  "firstname": "Elixir",
  "lastname": "Dude",
  "user_id": "1",
  "suburb_id": "1",
  "phone": "1234567890"
}
```

##### DELETE `/contact`

Deletes a contact.
This endpoint requires a JSON body with the following structure:

```json
{
  "user_id": 1,
  "contact_id": 2
}
```





## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `addressbook` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:addressbook, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/addressbook>.

