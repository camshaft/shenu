defmodule Test.Shenu.Message.URI do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse(%{"host" => "example.com", "path" => "/foo/bar"})
    |> assert_message(%URI{host: "example.com", path: "/foo/bar"})
  end

  test "default schema error" do
    create_parser()
    |> parse(%{"foo" => "bar"})
    |> assert_error()
  end
end
