defmodule Shenu.Message.Date do
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
      }
    },
    additionalProperties: false
  }
end

defimpl Calendar.ContainsDate, for: Shenu.Message.Date do
  def date_struct(%{year: y, month: m, day: d}) do
    Calendar.Date.from_erl!({y, m, d})
  end
end

defimpl Shenu.Message, for: Shenu.Message.Date do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, _) do
    Calendar.Date.diff(a, b)
  end
end
