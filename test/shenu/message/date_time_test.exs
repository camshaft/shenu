defmodule Test.Shenu.Message.DateTime do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse(%{"year" => 2016, "month" => 5, "day" => 30, "hour" => 21, "minute" => 56, "second" => 5, "timezone" => "America/Denver"})
    |> assert_message(%DateTime{year: 2016, month: 5, day: 30, hour: 21, minute: 56, second: 5, timezone: "America/Denver"})
  end

  test "default schema error" do
    parser = create_parser()

    parser
    |> parse(%{"hour" => 26})
    |> assert_error()
  end
end
