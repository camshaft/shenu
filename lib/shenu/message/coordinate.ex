defmodule Shenu.Message.Coordinate do
  use Shenu.Message

  defstruct dimensions: %{}

  def new(dimensions \\ %{}) when is_map(dimensions) do
    cast(%{dimensions: dimensions})
  end

  def schema(dimensions \\ [])
  def schema(dimensions) when is_list(dimensions) do
    dimensions
    |> Enum.reduce(%{}, fn(key, acc) ->
      Map.put(acc, key, %{"type" => "number"})
    end)
    |> schema()
  end
  def schema(dimensions) when is_map(dimensions) and map_size(dimensions) > 0 do
    %{
      "type" => "object",
      "properties" => dimensions,
      "required" => Map.keys(dimensions),
      "additionalProperties" => false
    }
  end
  def schema(_) do
    %{
      "type" => "object"
    }
  end
end

defimpl Shenu.Message, for: Shenu.Message.Coordinate do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, :default) do
    difference(a, b, :cartesian)
  end
  def difference(%{dimensions: a}, %{dimensions: b}, :cartesian) do
    keys = Map.keys(a)
    ^keys = Map.keys(b)
    keys
    |> Enum.reduce(0, fn(key, acc) ->
      a_val = Map.get(a, key) || 0
      b_val = Map.get(b, key) || 0
      v = b_val - a_val
      v * v + acc
    end)
    |> :math.sqrt()
  end
end
