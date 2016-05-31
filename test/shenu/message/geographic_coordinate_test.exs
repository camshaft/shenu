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
end
