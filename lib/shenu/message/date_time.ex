defmodule Shenu.Message.DateTime do
  use Shenu.Message

  defmessage %{
    type: "object",
    properties: %{
      year: %{
        type: "integer"
      },
      month: %{
        type: "integer",
        minimum: 1,
        maximum: 12
      },
      day: %{
        type: "integer",
        minimum: 1,
        maximum: 31
      },
      hour: %{
        type: "integer",
        minimum: 0,
        maximum: 23
      },
      minute: %{
        type: "integer",
        minimum: 0,
        maximum: 59
      },
      second: %{
        type: "integer",
        minimum: 0,
        maximum: 59
      },
      timezone: %{
        type: "string",
        default: "UTC"
      }
    },
    additionalProperties: false
  }
end

defimpl Calendar.ContainsDateTime, for: Shenu.Message.DateTime do
  def dt_struct(%{year: y,
                  month: m,
                  day: d,
                  hour: h,
                  minute: mm,
                  second: s,
                  timezone: t}) do
    Calendar.DateTime.from_erl!({{y, m, d}, {h, mm, s}}, t)
  end
end

defimpl Shenu.Message, for: Shenu.Message.DateTime do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, _) do
    case Calendar.DateTime.diff(a, b) do
      {:ok, secs, _, _} ->
        secs
    end
  end
end
