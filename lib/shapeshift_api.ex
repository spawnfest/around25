defmodule ShapeShiftApi do
  @moduledoc """
  Documentation of all the API calls and the corresponding parameters.
  """

  def get_coins() do
    invoke_public_api("/getcoins")
  end

  def get_deposit_limits(pair) do
    invoke_public_api("/limit/" <> pair)
  end

  def get_exchange_rate(pair) do
    invoke_public_api("/rate/" <> pair)
  end

  def get_market_info(pair) do
    invoke_public_api("/marketinfo/" <> pair)
  end

  def get_recent_transactions(limit) do
    invoke_public_api("/recenttx/" <> limit)
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
