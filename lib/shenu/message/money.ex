defmodule Shenu.Message.Money do
  defstruct currency: "USD",
            amount: 0

  def new(opts \\ []) do
    struct(__MODULE__, opts)
  end
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
