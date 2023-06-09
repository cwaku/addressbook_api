defmodule Addressbook.Validate do
  alias Addressbook.Constants.Constants

  def parse_first_name(nil) do
    {:error, Constants.err_missing_first_name}
  end

  def parse_first_name("") do
    {:error, Constants.err_missing_first_name}
  end

  def parse_first_name(first_name) do
    if is_binary(first_name) do
      {:ok, first_name}
    else
      {:error, Addressbook.Constants.Constants.err_first_name}
    end
  end

  def parse_last_name(nil) do
    {:error, Constants.err_missing_last_name}
  end

  def parse_last_name("") do
    {:error, Constants.err_missing_last_name}
  end

  def parse_last_name(last_name) do
    if is_binary(last_name) do
      {:ok, last_name}
    else
      {:error, Constants.err_last_name}
    end
  end

  def parse_phone_number(nil) do
    {:error, Constants.err_missing_phone_number}
  end

  def parse_phone_number("") do
    {:error, Constants.err_missing_phone_number}
  end

  def parse_phone_number(phone_number) do
    if String.length(phone_number) == 10 do
      {:ok, phone_number}
    else
      {:error, Constants.err_phone_number}
    end
  end

  def parse_phone_number_validate(nil) do
    {:error, Constants.err_missing_phone_number_validate}
  end

  def parse_phone_number_validate("") do
    {:error, Constants.err_missing_phone_number_validate}
  end

  def parse_phone_number_validate(phone_number) do
    if String.length(phone_number) == 12 do
      {:ok, phone_number}
    else
      {:error, Constants.err_phone_number_validate}
    end
  end

  def parse_user_id(nil) do
    {:error, Constants.err_missing_user_id}
  end

  def parse_user_id(" ") do
    {:error, Constants.err_missing_user_id}
  end

  def parse_user_id(user_id) do
    IO.puts user_id
    if is_number(String.to_integer(user_id)) do
      {:ok, user_id}
    else
      {:error, Constants.err_user_id}
    end
  end

  def parse_suburb_id(nil) do
    {:error, Constants.err_missing_suburb_id}
  end

  def parse_suburb_id("") do
    {:error, Constants.err_missing_suburb_id}
  end

  def parse_suburb_id(suburb_id) do
    if is_number(suburb_id) do
      {:ok, suburb_id}
    else
      {:error, Constants.err_suburb_id}
    end
  end

  def parse_contact_id(nil) do
    {:error, Constants.err_missing_contact_id}
  end
  def parse_contact_id("") do
    {:error, Constants.err_missing_contact_id}
  end
  def parse_contact_id(contact_id) do
    if is_binary(contact_id) do
      {:ok, contact_id}
    else
      {:error, Constants.err_contact_id}
    end
  end

  def parse_source(nil) do
    {:error, Constants.err_missing_source}
  end

  def parse_source("") do
    {:error, Constants.err_missing_source}
  end

  # def parse_source(source) do
  #   if is_binary(source) do
  #     {:ok, source}
  #   else
  #     {:error, Constants.err_source}
  #   end
  # end
end
