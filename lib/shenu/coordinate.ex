defmodule Shenu.Coordinate do
  defstruct dimensions: %{}

  def new(dimensions \\ []) do
    dimensions = Enum.into(dimensions, %{})
    %__MODULE__{dimensions: dimensions}
  end
end

defimpl Shenu, for: Shenu.Coordinate do
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
