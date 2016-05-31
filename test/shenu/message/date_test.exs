defmodule Test.Shenu.Message.Date do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse(%{"year" => 2016, "month" => 5, "day" => 30})
    |> assert_message(%Date{year: 2016, month: 5, day: 30})
  end

  test "default schema error" do
    parser = create_parser()

    parser
    |> parse(%{"month" => 20})
    |> assert_error()

    parser
    |> parse(%{"day" => 32})
    |> assert_error()
  end
end
