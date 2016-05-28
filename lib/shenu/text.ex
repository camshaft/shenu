defmodule Shenu.Text do
  defstruct value: ""

  def new(value \\ "") do
    %__MODULE__{value: value}
  end
end

defimpl Shenu, for: BitString do
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

defimpl Shenu, for: Shenu.Text do
  def difference(%{value: a}, %{value: b}, method) do
    Shenu.BitString.difference(a, b, method)
  end
end
