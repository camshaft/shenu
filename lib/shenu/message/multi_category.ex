defmodule Shenu.Message.MultiCategory do
  use Shenu.Message

  defmessage %{
    type: "array",
  }

  def schema(acceptable) when is_list(acceptable) and length(acceptable) > 0 do
    super(acceptable)
    |> Map.put("items", %{"enum" => acceptable})
  end
  def schema(opts) do
    super(opts)
  end
end

defimpl Shenu.Message, for: Shenu.Message.MultiCategory do
  def difference(m, m, _) do
    0
  end
  def difference(%{value: a}, %{value: b}, _) do
    compare(a, b) + compare(b, a)
  end

  defp compare(a, b) do
    length(a -- b)
  end
end
