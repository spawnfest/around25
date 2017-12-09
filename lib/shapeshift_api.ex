defmodule ShapeShiftApi do
  @moduledoc """
  Documentation of all the API calls and the corresponding parameters.
  """

  @doc """
    iex> {:ok, response} = ShapeShiftApi.get_coins
    iex> is_map response
    true
  """
  def get_coins() do
    invoke_public_api("/getcoins")
  end

  @doc """
    iex> {:ok, response} = ShapeShiftApi.get_deposit_limits "BTC_ETH"
    iex> is_map response
    true
  """
  def get_deposit_limits(pair) do
    invoke_public_api("/limit/" <> pair)
  end

  @doc """
    iex> {:ok, response} = ShapeShiftApi.get_exchange_rate "BTC_ETH"
    iex> is_map response
    true
  """
  def get_exchange_rate(pair) do
    invoke_public_api("/rate/" <> pair)
  end

  @doc """
    iex> {:ok, response} = ShapeShiftApi.get_market_info "BTC_ETH"
    iex> is_map response
    true
  """
  def get_market_info(pair) do
    invoke_public_api("/marketinfo/" <> pair)
  end

  @doc """
    iex> {:ok, response} = ShapeShiftApi.get_market_info
    iex> is_list response
    true
  """
  def get_market_info() do
    invoke_public_api("/marketinfo")
  end

  @doc """
    iex> {:ok, response} = ShapeShiftApi.get_recent_transactions 10
    iex> is_list response
    true
  """
  def get_recent_transactions(limit) do
    invoke_public_api("/recenttx/" <> Integer.to_string(limit))
  end

  def validate_address(address, pair) do
    invoke_public_api("/validateAddress/" <> address <> "/" <> pair)
  end

  def get_status(deposit_address) do
    invoke_public_api("/txStat/" <> deposit_address)
  end

  def get_time_remaining_to_deposit(deposit_address) do
    invoke_public_api("/timeremaining/" <> deposit_address)
  end

  def get_transactions() do
    invoke_private_api("GET", "/txbyapikey")
  end

  def get_transactions(deposit_address) do
    invoke_private_api("GET", "/txbyapikey/" <> deposit_address)
  end

  def send_amount(ammount, pair, withdrawl_address, return_address) do
    invoke_private_api("POST", "/sendammount", %{ammount: ammount, pair: pair, withdrawl: withdrawl_address, returnAddress: return_address})
  end

  def quote(pair, ammount) do
    invoke_private_api("POST", "/sendammount", %{pair: pair, ammount: ammount})
  end

  def shift(withdrawal_address, pair, return_address) do
    invoke_private_api("POST", "/shift", %{pair: pair, withdrawl: withdrawal_address, returnAddress: return_address})
  end

  def cancel_pending(address) do
    invoke_private_api("POST", "/cancelpending", %{address: address})
  end

  def send_email_receipt(email, transaction) do
    invoke_private_api("POST", "/mail", %{email: email, txid: transaction})
  end

  # Helper method to invoke the public APIs
  # Returns a tuple {status, result}
  defp invoke_public_api(method) do
    query_url = Application.get_env(:shapeshift_api, :api_endpoint) <> method
    case HTTPoison.get(query_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, Poison.decode!(body)}
      {:ok, %HTTPoison.Response{status_code: _, body: body}} -> {:error, Poison.decode!(body)}
      err -> {:error, err}
    end
  end

  defp invoke_private_api("GET", method) do
    api_endpont = Application.get_env(:shapeshift_api, :api_endpoint)
    api_key = Application.get_env(:shapeshift_api, :api_key)
    endpoint = api_endpont <> method <> "/" <> api_key

    case HTTPoison.get(endpoint) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, Poison.decode!(body)}
      {:ok, %HTTPoison.Response{status_code: _, body: body}} -> {:error, Poison.decode!(body)}
      err -> {:error, err}
    end
  end

  defp invoke_private_api("POST", method, params) do
    api_endpont = Application.get_env(:shapeshift_api, :api_endpoint)
    api_key = Application.get_env(:shapeshift_api, :api_key)
    endpoint = api_endpont <> method <> "/" <> api_key

    case HTTPoison.post(endpoint, params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, Poison.decode!(body)}
      {:ok, %HTTPoison.Response{status_code: _, body: body}} -> {:error, Poison.decode!(body)}
      err -> {:error, err}
    end
  end

end
