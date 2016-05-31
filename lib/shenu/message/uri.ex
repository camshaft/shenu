defmodule Shenu.Message.URI do
  use Shenu.Message

  defmessage %{
    type: "object",
    properties: %{
      fragment: %{
        type: "string"
      },
      host: %{
        type: "string",
        format: "hostname"
      },
      path: %{
        type: "string"
      },
      port: %{
        type: "integer",
        minimum: 0
      },
      query: %{
        type: "string"
      },
      scheme: %{
        type: "string"
      },
      userinfo: %{
        type: "string"
      }
    },
    additionalProperties: false
  }
end

defimpl Shenu.Message, for: Shenu.Message.URI do
  def difference(a, b, method) do
    Enum.reduce(unquote(Map.from_struct(%Shenu.Message.URI{}) |> Map.keys()), 0, fn(key, acc) ->
      a_v = a |> Map.get(key) |> to_string()
      b_v = b |> Map.get(key) |> to_string()
      acc + Shenu.Message.BitString.difference(a_v, b_v, method)
    end)
  end
end
