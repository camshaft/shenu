defmodule Shenu.Message.Time do
  use Shenu.Message

  defmessage %{
    type: "object",
    properties: %{
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
      }
    },
    additionalProperties: false
  }
end

defimpl Calendar.ContainsTime, for: Shenu.Message.Time do
  def time_struct(%{hour: h, minute: m, second: s}), do: Calendar.Time.from_erl!({h, m, s})
end

defimpl Shenu.Message, for: Shenu.Message.Time do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, _) do
    Calendar.Time.diff(a, b)
  end
end
