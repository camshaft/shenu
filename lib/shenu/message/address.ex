defmodule Shenu.Message.Address do
  use Shenu.Message

  defmessage %{
    type: "object",
    properties: %{
      street_address: %{
        type: "string"
      },
      extended_address: %{
        type: "string"
      },
      post_office_box: %{
        type: "string"
      },
      postal_code: %{
        type: "string"
      },
      locality: %{
        type: "string"
      },
      region: %{
        type: "string"
      },
      country_name: %{
        type: "string"
      },
    },
    required: [:country_name, :locality, :region],
    additionalProperties: false
  }
end

defimpl Shenu.Message, for: Shenu.Message.Address do
  ## TODO support distance with google maps, maybe?
  ##      for now, we'll just use a textual difference
  def difference(a, b, method) do
    Enum.reduce(unquote(Map.from_struct(%Shenu.Message.Address{}) |> Map.keys()), 0, fn(key, acc) ->
      a_v = a |> Map.get(key) |> to_string()
      b_v = b |> Map.get(key) |> to_string()
      acc + Shenu.Message.BitString.difference(a_v, b_v, method)
    end)
  end
end
