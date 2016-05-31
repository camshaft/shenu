defmodule Shenu.Message.Money do
  use Shenu.Message

  defmessage %{
    type: "object",
    properties: %{
      currency: %{
        type: "string",
        default: "USD"
      },
      amount: %{
        type: "decimal",
      }
    },
    required: [:amount],
    additionalProperties: false
  }
end

defimpl Shenu.Message, for: Shenu.Message.Money do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, :default) do
    difference(a, b, :usd)
  end
  def difference(a, b, :usd) do
    to_usd(a) - to_usd(b)
  end

  defp to_usd(%{currency: c, amount: a}) when c in [:usd, "USD", "usd"] do
    a
  end
  defp to_usd(%{currency: c, amount: a}) do
    YahooFx.rate(c, "USD")[:rate] * a
  end
end
