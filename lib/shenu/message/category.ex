defmodule Shenu.Message.Category do
  @moduledoc """
  Struct representing categorical selection/identification

      iex> a = Shenu.Message.Category.new("123")
      iex> b = Shenu.Message.Category.new("456")
      iex> Shenu.Message.difference(a, b)
      1

      iex> a = Shenu.Message.Category.new("123")
      iex> b = Shenu.Message.Category.new("123")
      iex> Shenu.Message.difference(a, b)
      0
  """

  defstruct id: nil

  def new(id \\ nil) do
    %__MODULE__{id: id}
  end
end

defimpl Shenu.Message, for: Shenu.Message.Category do
  def difference(m, m, _) do
    0
  end
  def difference(_, _, _) do
    1
  end
end
