defmodule Addressbook do
  use Plug.Router

  # alias Addressbook.{Contact, Repo}
  alias Addressbook.Validate
  alias Addressbook.Controller.Contact
  alias Addressbook.Controller.Region
  alias Addressbook.Controller.Suburb
  alias Addressbook.Controller.City

  # Attach the Logger to log incoming requests
  plug(Plug.Logger)

  plug(:match)
  plug(:dispatch)

  # Check if user exits with phone number
  get "/validate" do
    {:ok, body, conn} = read_body(conn)

    case Poison.decode(body) do
      {:ok, result} ->

        with {:ok, phone} <- Validate.parse_phone_number_validate(result["phone"]) do
          # remove 233 from the phone and after add prepend 0
          phone = "0" <> String.slice(phone, 3, 10)
          IO.puts phone

          case Contact.validate_user(phone) do
            {:ok, result} ->
              conn
              |> put_status(200)
              |> put_resp_header("content-type", "application/json")
              |> send_resp(200, Poison.encode!(result))

            {:error, reason} ->
              conn
              |> put_status(400)
              |> put_resp_header("content-type", "application/json")
              |> send_resp(400, Poison.encode!(reason))
          end
        else
          {:error, reason} ->
            conn
            |> put_status(400)
            |> put_resp_header("content-type", "application/json")
            |> send_resp(400, Poison.encode!(reason))
        end

      {:error, reason} ->
        conn
        |> put_status(400)
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, Poison.encode!(reason))
    end
  end

  post "/contact" do
    {:ok, body, conn} = read_body(conn)
    IO.inspect(body)

    case Poison.decode(body) do
      {:ok, result} ->
        with {:ok, firstname} <- Validate.parse_first_name(result["firstname"]),
             {:ok, lastname} <- Validate.parse_last_name(result["lastname"]),
             {:ok, user_id} <- Validate.parse_user_id(result["user_id"]),
             {:ok, suburb_id} <- Validate.parse_suburb_id(result["suburb_id"]),
            #  {:ok, source} <- Validate.parse_source(result["source"]),
             {:ok, phone} <- Validate.parse_phone_number(result["phone"]) do
          contact = %{
            firstname: firstname,
            lastname: lastname,
            phone: phone,
            user_id: user_id,
            suburb_id: suburb_id,
            source: result["source"]
          }

          case Contact.save_contact(contact) do
            {:ok, result} ->
              IO.inspect(result)

              conn
              |> put_status(201)
              |> put_resp_header("content-type", "application/json")
              |> send_resp(201, Poison.encode!(result))

            {:error, reason} ->
              conn
              |> put_status(400)
              |> put_resp_header("content-type", "application/json")
              |> send_resp(400, Poison.encode!(reason))
          end
        else
          {:error, reason} ->
            conn
            |> put_status(400)
            |> put_resp_header("content-type", "application/json")
            |> send_resp(400, Poison.encode!(reason))
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  # Get all contacts belong to user
  get "/contacts/:user_id" do
    user_id = conn.params["user_id"]
    {:ok, body, conn} = read_body(conn)
    IO.inspect body
    IO.inspect user_id

    case Validate.parse_user_id(user_id) do
      {:ok, user_id} ->
        case Contact.get_contacts(user_id) do
          {:ok, result} ->
            conn
            |> put_status(200)
            |> put_resp_header("content-type", "application/json")
            |> send_resp(200, Poison.encode!(result))

          {:error, reason} ->
            conn
            |> put_status(400)
            |> put_resp_header("content-type", "application/json")
            |> send_resp(400, Poison.encode!(reason))
        end

      {:error, reason} ->
        conn
        |> put_status(400)
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, Poison.encode!(reason))
    end
  end

  # Delete contact
  delete "/contact" do
    # contact_id = conn.params["contact_id"]
    {:ok, body, conn} = read_body(conn)
    # read params for contact id

    case Poison.decode(body) do
      {:ok, result} ->
        with {:ok, user_id} <- Validate.parse_user_id(result["user_id"]),
             {:ok, contact_id} <- Validate.parse_contact_id(result["contact_id"]) do
          case Contact.delete_contact(user_id, contact_id) do
            {:ok, result} ->
              conn
              |> put_status(200)
              |> put_resp_header("content-type", "application/json")
              |> send_resp(200, Poison.encode!(result))

            {:error, reason} ->
              conn
              |> put_status(400)
              |> put_resp_header("content-type", "application/json")
              |> send_resp(400, Poison.encode!(reason))
          end
        else
          {:error, reason} ->
            conn
            |> put_status(400)
            |> put_resp_header("content-type", "application/json")
            |> send_resp(400, Poison.encode!(reason))
        end

      {:error, _reason} ->
        conn
        |> put_status(400)
        |> put_resp_header("content-type", "application/json")
        # |> send_resp(400, Poison.encode!(reason))
        # send response with reason set to "Invalid request, body should be JSON"
        |> send_resp(
          400,
          Poison.encode!(%{
            resp_code: "000",
            resp_msg: "Invalid request, body should be JSON"
          })
        )
    end
  end

  # update contact
  put "/contact/:user_id/:contact_id" do
    user_id = conn.params["user_id"]
    contact_id = conn.params["contact_id"]
    {:ok, body, conn} = read_body(conn)

    case Poison.decode(body) do
      {:ok, result} ->
        with {:ok, firstname} <- Validate.parse_first_name(result["firstname"]),
             {:ok, lastname} <- Validate.parse_last_name(result["lastname"]),
             {:ok, user_id} <- Validate.parse_user_id(user_id),
             {:ok, suburb_id} <- Validate.parse_suburb_id(result["suburb_id"]),
             {:ok, phone} <- Validate.parse_phone_number(result["phone"]),
             {:ok, contact_id} <- Validate.parse_contact_id(contact_id) do
          contact = %{
            firstname: firstname,
            lastname: lastname,
            phone: phone,
            user_id: user_id,
            suburb_id: suburb_id,
            contact_id: contact_id
          }

          case Contact.update_contact(user_id, contact_id, contact) do
            {:ok, result} ->
              conn
              |> put_status(200)
              |> put_resp_header("content-type", "application/json")
              |> send_resp(200, Poison.encode!(result))

            {:error, reason} ->
              conn
              |> put_status(400)
              |> put_resp_header("content-type", "application/json")
              |> send_resp(400, Poison.encode!(reason))
          end
        else
          {:error, reason} ->
            conn
            |> put_status(400)
            |> put_resp_header("content-type", "application/json")
            |> send_resp(400, Poison.encode!(reason))
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  # Get all Regions
  get "/regions" do
    case Region.get_regions() do
      {:ok, result} ->
        conn
        |> put_status(200)
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Poison.encode!(result))

      {:error, reason} ->
        conn
        |> put_status(400)
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, Poison.encode!(reason))
    end
  end

  # Get all Suburbs
  get "/suburbs" do
    case Suburb.get_suburbs() do
      {:ok, result} ->
        conn
        |> put_status(200)
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Poison.encode!(result))

      {:error, reason} ->
        conn
        |> put_status(400)
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, Poison.encode!(reason))
    end
  end

  # Get all cities
  get "/cities" do
    case City.get_cities() do
      {:ok, result} ->
        conn
        |> put_status(200)
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Poison.encode!(result))

      {:error, reason} ->
        conn
        |> put_status(400)
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, Poison.encode!(reason))
    end
  end

  # Handle requests that don't match any routes
  match _ do
    send_resp(conn, 404, "Not found")
  end
end
