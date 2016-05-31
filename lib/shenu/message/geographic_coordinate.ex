defmodule Shenu.Message.GeographicCoordinate do
  use Shenu.Message

  defmessage %{
    type: "object",
    properties: %{
      latitude: %{
        type: "number"
      },
      longitude: %{
        type: "number"
      },
      altitude: %{
        type: "number"
      }
    },
    required: [:latitude, :longitude],
    additionalProperties: false
  }
end

defimpl Geocalc.Point, for: Shenu.Message.GeographicCoordinate do
  def latitude(%{latitude: latitude}) do
    latitude
  end
  def longitude(%{longitude: longitude}) do
    longitude
  end
end

defimpl Shenu.Message, for: Shenu.Message.GeographicCoordinate do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, _) do
    Geocalc.distance_between(a, b)
  end
end
