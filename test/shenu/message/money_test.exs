defmodule Test.Shenu.Message.Money do
  use Test.Shenu.Message.Case

  test "default schema" do
    create_parser()
    |> parse(%{"amount" => 10.00})
    |> assert_message(%Money{amount: 10.0})
  end

  test "default schema w/ currency" do
    create_parser()
    |> parse(%{"amount" => 10.00, "currency" => "EUR"})
    |> assert_message(%Money{amount: 10.0, currency: "EUR"})
  end

  test "default schema error" do
    create_parser()
    |> parse(%{"foo" => "bar"})
    |> assert_error()
  end
end
