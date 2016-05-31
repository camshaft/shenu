defmodule Test.Shenu.Message.PhoneNumber do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse(%{"country_code" => 1, "national_number" => "8015551234"})
    |> assert_message(%PhoneNumber{country_code: 1, national_number: "8015551234"})
  end

  test "default schema error" do
    parser = create_parser()

    parser
    |> parse(%{"country_code" => "foo"})
    |> assert_error()

    parser
    |> parse(%{"national_number" => 1234})
    |> assert_error()

    parser
    |> parse(%{"foo" => "bar"})
  end
end
