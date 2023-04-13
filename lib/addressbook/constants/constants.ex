defmodule Addressbook.Macro do
  defmacro const(name, value) do
    quote do
      @doc "Constant #{unquote(name)}"
      def unquote(:"#{name}")(), do: unquote(value)
    end
  end
end



defmodule Addressbook.Constants.Constants do


  import Addressbook.Macro


  # constant

  const :err_first_name, %{ resp_code: "049", resp_msg: "First name must be a combination of alphanumeric characters" }

  const :err_last_name, %{ resp_code: "050", resp_msg: "Last name must be a combination of alphanumeric characters" }

  const :err_phone_number, %{ resp_code: "051", resp_msg: "Phone number must be a combination of 10 numeric characters" }
  const :err_phone_number_validate, %{ resp_code: "051", resp_msg: "Phone number must be a combination of 12 numeric characters" }
  const :err_missing_first_name, %{ resp_code: "052", resp_msg: "First name is required" }
  const :err_missing_last_name, %{ resp_code: "053", resp_msg: "Last name is required" }
  const :err_missing_phone_number, %{ resp_code: "054", resp_msg: "Phone number is required" }
  const :err_missing_phone_number_validate, %{ resp_code: "054", resp_msg: "Phone number is required" }
  const :err_missing_user_id, %{ resp_code: "055", resp_msg: "User ID is required" }
  const :err_user_id, %{ resp_code: "064", resp_msg: "User ID is required" }
  const :err_missing_suburb_id, %{ resp_code: "056", resp_msg: "Suburb ID is required" }
  const :err_suburb_id, %{ resp_code: "063", resp_msg: "Suburb ID is required" }
  const :err_missing_contact_id, %{ resp_code: "057", resp_msg: "Contact ID is required" }
  const :err_contact_id, %{ resp_code: "061", resp_msg: "Contact ID is required" }
  const :err_missing_contact, %{ resp_code: "058", resp_msg: "Contact does not exist" }
  const :err_missing_suburb, %{ resp_code: "059", resp_msg: "Suburb does not exist" }
  # const :err_suburb, %{ resp_code: "062", resp_msg: "Suburb does not exist" }
  const :err_missing_user, %{ resp_code: "060", resp_msg: "User does not exist" }
  const :err_missing_source, %{ resp_code: "071", res_msg: "Missing source"}
end
