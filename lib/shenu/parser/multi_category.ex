defmodule Shenu.Parser.MultiCategory do
  defstruct acceptable: nil,
            min: nil,
            max: nil
end

defimpl Shenu.Parser, for: Shenu.Parser.MultiCategory do
  def parse(parser, id) when is_binary(id) or is_float(id) or is_integer(id) do
    parse(parser, [id])
  end
  def parse(parser, ids) do
    with :ok <- validate_length(parser, ids),
         :ok <- validate_acceptable(parser, ids),
         do: Shenu.Message.MultiCategory.new(ids)
  end

  defp validate_length(%{min: min, max: max}, ids)
      when (is_nil(min) or is_integer(min) and length(ids) >= min) and
           (is_nil(max) or is_integer(max) and length(ids) <= max) do
    :ok
  end
  defp validate_length(_, ids) do
    {:error, %Shenu.Parser.InputError{value: ids}}
  end

  defp validate_acceptable(%{acceptable: nil}, _) do
    :ok
  end
  defp validate_acceptable(%{acceptable: acceptable}, ids) do
    case ids -- acceptable do
      [] ->
        :ok
      extra ->
        {:error, %Shenu.Parser.InputError{value: extra, expected: acceptable}}
    end
  end
end
