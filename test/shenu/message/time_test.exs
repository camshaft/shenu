defmodule Test.Shenu.Message.Time do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse(%{"hour" => 3, "minute" => 5, "second" => 40})
    |> assert_message(%Time{hour: 3, minute: 5, second: 40})
  end

  test "default schema error" do
    parser = create_parser()

    parser
    |> parse(%{"second" => 100})
    |> assert_error()

    parser
    |> parse(%{"minute" => 62})
    |> assert_error()
  end
end
