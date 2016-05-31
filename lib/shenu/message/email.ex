defmodule Shenu.Message.Email do
  use Shenu.Message

  defmessage %{
    type: "object",
    properties: %{
      user: %{
        type: "string"
      },
      domain: %{
        type: "string",
        format: "hostname"
      }
    },
    additionalProperties: false
  }
end

defimpl Shenu.Message, for: Shenu.Message.Email do
  def difference(a, b, method) do
    Enum.reduce(unquote(Map.from_struct(%Shenu.Message.Email{}) |> Map.keys()), 0, fn(key, acc) ->
      a_v = a |> Map.get(key) |> to_string()
      b_v = b |> Map.get(key) |> to_string()
      acc + Shenu.Message.BitString.difference(a_v, b_v, method)
    end)
  end
end
