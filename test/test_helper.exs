defmodule Test.Shenu.Message.Case do
  import ExUnit.Assertions

  defmacro __using__(_) do
    module = Module.split(__CALLER__.module) |> tl() |> Module.concat()
    quote do
      use ExUnit.Case, async: true

      import Shenu.Parser, only: [parse: 2]
      import Test.Shenu.Message.Case

      alias unquote(module)

      defp create_parser() do
        Shenu.Parser.new(unquote(module))
      end
      defp create_parser(opts) do
        Shenu.Parser.new(unquote(module), opts)
      end
    end
  end

  defmacro assert_message(actual, expected) do
    quote do
      assert unquote(expected) = unquote(actual)
    end
  end

  def assert_error(result) do
    assert {:error, _} = result
  end
end

ExUnit.start()
