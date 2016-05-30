defmodule Shenu.Parser.Coordinate do
  defstruct dimensions: ["x", "y"]
end

defimpl Shenu.Parser, for: Shenu.Parser.Coordinate do
  def parse(%{dimensions: dimensions}, values) when is_map(values) do
    case extract(dimensions, values) do
      {coord, []} ->
        Shenu.Message.Coordinate.new(coord)
      {_, _} ->
        {:error, %Shenu.Parser.InputError{value: values, expected: expected(dimensions)}}
    end
  end

  defp extract(dimensions, values) do
    Enum.reduce(dimensions, {%{}, []}, fn
      ({from, to}, acc) when is_binary(from) and (is_binary(to) or is_atom(to)) ->
        fetch(values, from, to, acc)
      (dimension, acc) when is_binary(dimension) or is_atom(dimension) ->
        fetch(values, dimension, dimension, acc)
    end)
  end

  defp fetch(values, from, to, {coord, missing}) do
    case Map.fetch(values, from) do
      :error ->
        {coord, [from | missing]}
      {:ok, value} when is_integer(value) or is_float(value) ->
        {Map.put(coord, to, value), missing}
      {:ok, _} ->
        {coord, [from | missing]}
    end
  end

  defp expected(dimensions) do
    Enum.reduce(dimensions, %{}, fn
      ({from, _}, acc) ->
        Map.put(acc, from, :_)
      (from, acc) ->
        Map.put(acc, from, :_)
    end)
  end
end
