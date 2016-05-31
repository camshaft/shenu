defmodule Test.Shenu.Message.MultiCategory do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse(["123"])
    |> assert_message(%MultiCategory{value: ["123"]})
  end

  test "default schema error" do
    create_parser()
    |> parse(1)
    |> assert_error()
  end

  test "enum schema" do
    parser = create_parser(["1", "2", "3"])

    parser
    |> parse(["1"])
    |> assert_message(%MultiCategory{value: ["1"]})

    parser
    |> parse(["1", "3"])
    |> assert_message(%MultiCategory{value: ["1", "3"]})

    parser
    |> parse([])
    |> assert_message(%MultiCategory{value: []})

    parser
    |> parse(["4"])
    |> assert_error()
  end
end
