defmodule Shenu.Message.Color do
  @moduledoc """
  RGBA color
  """

  use Shenu.Message

  defmessage %{
    type: "object",
    properties: %{
      r: %{
        type: "integer",
        minimum: 0,
        maximum: 255,
        default: 0
      },
      g: %{
        type: "integer",
        minimum: 0,
        maximum: 255,
        default: 0
      },
      b: %{
        type: "integer",
        minimum: 0,
        maximum: 255,
        default: 0
      },
      a: %{
        type: "number",
        minimum: 0.0,
        maximum: 1.0,
        default: 1.0
      }
    },
    additionalProperties: false
  }
end

defimpl Shenu.Message, for: Shenu.Message.Color do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, :default) do
    difference(a, b, :cie94)
  end
  def difference(a, b, :cie94) do
    ColorUtils.distance(convert(a), convert(b))
  end

  defp convert(%{r: r, g: g, b: b}) do
    %ColorUtils.RGB{red: r, green: g, blue: b}
  end
end
