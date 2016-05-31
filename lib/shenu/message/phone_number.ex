defmodule Shenu.Message.PhoneNumber do
  use Shenu.Message

  defmessage %{
    type: "object",
    properties: %{
      country_code: %{
        type: "integer"
      },
      national_number: %{
        type: "integer"
      }
    },
    additionalProperties: false
  }
end

defimpl Shenu.Message, for: Shenu.Message.PhoneNumber do
  def difference(m, m, _) do
    0
  end
  def difference(_, _, _) do
    1
  end
end
