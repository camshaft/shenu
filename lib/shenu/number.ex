defmodule Shenu.Number do
  defstruct value: 0

  def new(value) do
    %__MODULE__{value: value}
  end
end

defimpl Shenu, for: [Integer, Float] do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, _) do
    a - b
  end
end

defimpl Shenu, for: Shenu.Number do
  def difference(%{value: a}, %{value: b}, method) do
    Shenu.Integer.difference(a, b, method)
  end
end
