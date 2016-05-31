defmodule Shenu.Message.Text do
  use Shenu.Message

  defmessage %{
    type: "string"
  }
end

defimpl Shenu.Message, for: BitString do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, :default) do
    difference(a, b, :jaro)
  end
  def difference(a, b, method) do
    case TheFuzz.compare(method, a, b) do
      nil ->
        1
      distance when method in [:hamming, :levenshtein, :weighted_levenshtein] ->
        distance
      diff ->
        1 - diff
    end
  end
end

defimpl Shenu.Message, for: Shenu.Message.Text do
  def difference(%{value: a}, %{value: b}, method) do
    Shenu.Message.BitString.difference(a, b, method)
  end
end
