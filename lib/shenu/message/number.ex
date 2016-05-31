defmodule Shenu.Message.Number do
  use Shenu.Message

  defmessage %{
    type: "number",
    default: 0
  }
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
