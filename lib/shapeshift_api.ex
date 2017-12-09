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
    iex> {:ok, response} = ShapeShiftApi.get_recent_transactions 10
    iex> is_list response
    true
  """
  def get_recent_transactions(limit) do
    invoke_public_api("/recenttx/" <> Integer.to_string(limit))
  end

  def get_status(deposit_address) do
    invoke_public_api("/txStat/" <> deposit_address)
  end

  def get_transactions(apiKey) do

  end

  def send_amount(pair, options) do

  end

  def quote(pair, options) do

  end

  def shift(withdrawal_address, pair, options, true) do

  end

  def shift(withdrawal_address, pair, options, false) do

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

end
