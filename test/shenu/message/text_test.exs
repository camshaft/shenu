defmodule Test.Shenu.Message.Text do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse("Hello, world!")
    |> assert_message(%Text{value: "Hello, world!"})
  end

  test "default schema error" do
    create_parser()
    |> parse(123)
    |> assert_error()
  end
end
