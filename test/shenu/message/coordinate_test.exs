defmodule Test.Shenu.Message.Coordinate do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse(%{"x" => 123, "y" => 345})
    |> assert_message(%Coordinate{dimensions: %{"x" => 123, "y" => 345}})
  end

  test "list dimensions schema" do
    parser = create_parser(["x", "y"])

    parser
    |> parse(%{"x" => 1, "y" => 2})
    |> assert_message(%Coordinate{dimensions: %{"x" => 1, "y" => 2}})

    parser
    |> parse(%{"y" => 1})
    |> assert_error()

    parser
    |> parse(%{"x" => 1, "y" => 1, "z" => 1})
    |> assert_error()
  end

  test "map dimensions schema" do
    parser = create_parser(%{"x" => %{"type" => "integer", "minimum" => 20, "maximum" => 100}})

    parser
    |> parse(%{"x" => 20})
    |> assert_message(%Coordinate{dimensions: %{"x" => 20}})

    parser
    |> parse(%{"x" => 1})
    |> assert_error()

    parser
    |> parse(%{"x" => 200})
    |> assert_error()

    parser
    |> parse(%{"x" => 1.2})
    |> assert_error()
  end
end
