defmodule Test.Shenu.Message.Email do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse(%{"user" => "cameron", "domain" => "foo.com"})
    |> assert_message(%Email{user: "cameron", domain: "foo.com"})
  end

  test "default schema error" do
    parser = create_parser()

    parser
    |> parse(%{"domain" => "foo"})
    |> assert_error()

    parser
    |> parse(%{"foo" => "bar"})
    |> assert_error()
  end
end
