defmodule Shenu.URI do
  defstruct authority: nil,
            fragment: nil,
            host: nil,
            path: nil,
            port: nil,
            query: nil,
            scheme: nil,
            userinfo: nil

  def new(opts \\ []) do
    struct(__MODULE__, opts)
  end
end

defimpl Shenu, for: Shenu.URI do
  def difference(a, b, method) do
    Enum.reduce(unquote(Map.from_struct(%Shenu.URI{}) |> Map.keys()), 0, fn(key, acc) ->
      a_v = a |> Map.get(key) |> to_string()
      b_v = b |> Map.get(key) |> to_string()
      acc + Shenu.BitString.difference(a_v, b_v, method)
    end)
  end
end
