defmodule Test.Shenu.Message.Category do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse("123")
    |> assert_message(%Category{value: "123"})
  end

  test "default schema error" do
    create_parser()
    |> parse(1)
    |> assert_error()
  end

  test "enum schema" do
    create_parser(["1", "2", "3"])
    |> parse("1")
    |> assert_message(%Category{value: "1"})
  end

  test "enum schema error" do
    create_parser(["1", "2", "3"])
    |> parse("4")
    |> assert_error()
  end
end
