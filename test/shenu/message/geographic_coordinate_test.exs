defmodule Test.Shenu.Message.GeographicCoordinate do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse(%{"latitude" => 48.9, "longitude" => 2.3, "altitude" => 2630})
    |> assert_message(%GeographicCoordinate{latitude: 48.9, longitude: 2.3, altitude: 2630})
  end

  test "default schema error" do
    create_parser()
    |> parse(%{})
    |> assert_error()
  end

  test "difference" do
    london = %GeographicCoordinate{latitude: 51.5286416, longitude: -0.1015987}
    paris = %GeographicCoordinate{latitude: 48.8588589, longitude: 2.3475569}
    d = Shenu.Message.difference(london, paris)
    assert d == 344229.88946533133
  end
end
