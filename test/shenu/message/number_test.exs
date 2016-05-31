defmodule Test.Shenu.Message.Number do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse(123)
    |> assert_message(%Number{value: 123})
  end

  test "default schema float" do
    create_parser()
    |> parse(123.456)
    |> assert_message(%Number{value: 123.456})
  end

  test "default schema error" do
    create_parser()
    |> parse("123")
    |> assert_error()
  end
end
