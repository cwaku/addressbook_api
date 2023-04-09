defmodule Addressbook.Constants do
  # declare constants here
  @spec err_first_name :: %{resp_code: <<_::24>>, resp_msg: <<_::472>>}
  def err_first_name do
    %{
      resp_code: "049",
      resp_msg: "First name must be a combination of alphanumeric characters"
    }
  end

  @spec err_last_name :: %{resp_code: <<_::24>>, resp_msg: <<_::464>>}
  def err_last_name do
    %{
      resp_code: "050",
      resp_msg: "Last name must be a combination of alphanumeric characters"
    }
  end

  @spec err_phone_number :: %{resp_code: <<_::24>>, resp_msg: <<_::472>>}
  def err_phone_number do
    %{
      resp_code: "051",
      resp_msg: "Phone number must be a combination of 10 numeric characters"
    }
  end

  @spec err_missing_first_name :: %{resp_code: <<_::24>>, resp_msg: <<_::176>>}
  def err_missing_first_name do
    %{
      resp_code: "052",
      resp_msg: "First name is required"
    }
  end

  @spec err_missing_last_name :: %{resp_code: <<_::24>>, resp_msg: <<_::168>>}
  def err_missing_last_name do
    %{
      resp_code: "053",
      resp_msg: "Last name is required"
    }
  end

  @spec err_missing_phone_number :: %{resp_code: <<_::24>>, resp_msg: <<_::192>>}
  def err_missing_phone_number do
    %{
      resp_code: "054",
      resp_msg: "Phone number is required"
    }
  end

  @spec err_user_id :: %{resp_code: <<_::24>>, resp_msg: <<_::448>>}
  def err_user_id do
    %{
      resp_code: "055",
      resp_msg: "User id must be a combination of alphanumeric characters"
    }
  end

  @spec err_suburb_id :: %{resp_code: <<_::24>>, resp_msg: <<_::464>>}
  def err_suburb_id do
    %{
      resp_code: "056",
      resp_msg: "Suburb id must be a combination of alphanumeric characters"
    }
  end

  @spec err_missing_user_id :: %{resp_code: <<_::24>>, resp_msg: <<_::152>>}
  def err_missing_user_id do
    %{
      resp_code: "057",
      resp_msg: "User id is required"
    }
  end

  @spec err_missing_suburb_id :: %{resp_code: <<_::24>>, resp_msg: <<_::168>>}
  def err_missing_suburb_id do
    %{
      resp_code: "058",
      resp_msg: "Suburb id is required"
    }
  end
end
