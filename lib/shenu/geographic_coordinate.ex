defmodule Shenu.GeographicCoordinate do
  defstruct [latitude: 0,
             longitude: 0,
             # elevation: 0 ?
            ]

  def new(opts \\ []) do
    struct(__MODULE__, opts)
  end
end

defimpl Geocalc.Point, for: Shenu.GeographicCoordinate do
  def latitude(%{latitude: latitude}) do
    latitude
  end
  def longitude(%{longitude: longitude}) do
    longitude
  end
end

defimpl Shenu, for: Shenu.GeographicCoordinate do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, _) do
    Geocalc.distance_between(a, b)
  end
end
