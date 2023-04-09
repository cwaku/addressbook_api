defmodule Addressbook do
  use Plug.Router

  #alias Addressbook.{Contact, Repo}
  alias Addressbook.Validate
  alias Addressbook.Processor

  # Attach the Logger to log incoming requests
  plug(Plug.Logger)

  plug :match
  plug :dispatch


  # @moduledoc """
  # Documentation for `Addressbook`.
  # """

  # @doc """
  # Hello world.

  # ## Examples

  #     iex> Addressbook.hello()
  #     :world

  # """
  get "/hello" do
    conn
    |> send_resp(200, "You are gay!")
  end

  # post "/contact"

  # Create an endpint to create contact



  post "/contact" do
    {:ok, body, conn} = read_body(conn)
    IO.inspect body

    case Poison.decode(body) do
      {:ok, result}->
        with {:ok, firstname} <- Validate.parse_first_name(result["firstname"]),
              {:ok, lastname} <- Validate.parse_last_name(result["lastname"]),
              {:ok, user_id} <- Validate.parse_user_id(result["user_id"]),
              {:ok, suburb_id} <- Validate.parse_suburb_id(result["suburb_id"]),
              {:ok, phone} <- Validate.parse_phone_number(result["phone"]) do
        contact =%{firstname: firstname, lastname: lastname, phone: phone, user_id: user_id, suburb_id: suburb_id}
            case Processor.save_contact(contact) do
              {:ok, result}->
                IO.inspect result
                conn
                |> put_status(201)
                |> put_resp_header("content-type", "application/json")
                |> send_resp(201, Poison.encode!(result))
                # {:ok, Poison.encode!(result)}

              {:error, reason}->
                conn
                |> put_status(400)
                |> put_resp_header("content-type", "application/json")
                |> send_resp(400, Poison.encode!(reason))
                # {:error, Poison.encode!(reason)}
            end
        else
          {:error, reason}->
            conn
            |> put_status(400)
            |> put_resp_header("content-type", "application/json")
            |> send_resp(400, Poison.encode!(reason))
            # {:error, Poison.encode!(reason)}
        end
        # end
      {:error, reason}->
        # conn
        # |> put_status(400)
        # |> put_resp_header("content-type", "application/json")
        # |> send_resp(400, Poison.encode!(%{error: "Invalid request body"}))
        {:error, reason}
    end
  end

  # post "/contacts", plug(Addressbook.ContactController.create(conn))

  # Handle requests that don't match any routes
  match _ do
    send_resp(conn, 404, "Not found")
  end
end
