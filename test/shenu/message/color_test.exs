defmodule Test.Shenu.Message.Color do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse(%{"r" => 255, "g" => 255, "b" => 255, "a" => 0.2})
    |> assert_message(%Color{r: 255, g: 255, b: 255, a: 0.2})
  end

  test "default schema error" do
    create_parser()
    |> parse(%{"foo" => "bar"})
    |> assert_error()
  end
end
