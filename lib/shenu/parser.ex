defprotocol Shenu.Parser do
  def parse(parser, input)
  def affordance(parser)
end

defmodule Shenu.Parser.InputError do
  defexception [:value, :expected]

  def message(%{value: value, expected: nil}) do
    "Invalid input #{inspect(value)}"
  end
  def message(%{value: value, expected: expected}) do
    "Invalid input #{inspect(value)}. Expected #{inspect(expected)}"
  end
end
