defmodule Test.Shenu.Message.Address do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse(%{"country_name" => "USA",
               "locality" => "Salt Lake City",
               "region" => "Utah"})
    |> assert_message(%Address{country_name: "USA",
                               locality: "Salt Lake City",
                               region: "Utah"})
  end

  test "default schema error" do
    create_parser()
    |> parse(%{})
    |> assert_error()
  end
end
