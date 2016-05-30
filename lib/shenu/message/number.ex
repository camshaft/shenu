defmodule Shenu.Message.Number do
  defstruct value: 0

  def new(value) do
    %__MODULE__{value: value}
  end
end

defimpl Shenu.Message, for: [Integer, Float] do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, _) do
    a - b
  end
end

defimpl Shenu.Message, for: Shenu.Message.Number do
  def difference(%{value: a}, %{value: b}, method) do
    Shenu.Message.Integer.difference(a, b, method)
  end
end
