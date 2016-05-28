defmodule Shenu.Category do
  @moduledoc """
  Struct representing categorical selection/identification

      iex> a = Shenu.Category.new("123")
      iex> b = Shenu.Category.new("456")
      iex> Shenu.difference(a, b)
      1

      iex> a = Shenu.Category.new("123")
      iex> b = Shenu.Category.new("123")
      iex> Shenu.difference(a, b)
      0
  """

  defstruct id: nil

  def new(id \\ nil) do
    %__MODULE__{id: id}
  end
end

defimpl Shenu, for: Shenu.Category do
  def difference(m, m, _) do
    0
  end
  def difference(_, _, _) do
    1
  end
end
