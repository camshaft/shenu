defmodule Shenu.Message.MultiCategory do
  defstruct categories: []

  def new(list \\ []) do
    set = Enum.into(list, MapSet.new())
    %__MODULE__{categories: set}
  end
end

defimpl Shenu.Message, for: Shenu.Message.MultiCategory do
  def difference(m, m, _) do
    0
  end
  def difference(%{categories: a}, %{categories: b}, _) do
    compare(a, b) + compare(b, a)
  end

  defp compare(a, b) do
    Set.difference(a, b) |> Set.size()
  end
end