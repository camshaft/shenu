defmodule Shenu.Parser.Category do
  defstruct acceptable: nil
end

defimpl Shenu.Parser, for: Shenu.Parser.Category do
  alias Shenu.Message.Category

  def parse(%{acceptable: nil}, value) do
    Category.new(value)
  end
  def parse(%{acceptable: acceptable}, value) when is_list(acceptable) do
    if value in acceptable do
      Category.new(value)
    else
      {:error, %Shenu.Parser.InputError{value: value, expected: acceptable}}
    end
  end
  def parse(%{acceptable: value}, value) do
    Category.new(value)
  end
  def parse(%{acceptable: acceptable}, value) do
    {:error, %Shenu.Parser.InputError{value: value, expected: acceptable}}
  end
end
