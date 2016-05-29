defmodule Shenu.Address do
  defstruct number: nil,
            street: nil,
            unit: nil,
            city: nil,
            district: nil,
            region: nil,
            postcode: nil

  def new(opts \\ []) do
    struct(__MODULE__, opts)
  end
end

defimpl Shenu, for: Shenu.Address do
  ## TODO support distance with google maps, maybe?
  ##      for now, we'll just use a textual difference
  def difference(a, b, method) do
    Enum.reduce(unquote(Map.from_struct(%Shenu.Address{}) |> Map.keys()), 0, fn(key, acc) ->
      a_v = a |> Map.get(key) |> to_string()
      b_v = b |> Map.get(key) |> to_string()
      acc + Shenu.BitString.difference(a_v, b_v, method)
    end)
  end
end
