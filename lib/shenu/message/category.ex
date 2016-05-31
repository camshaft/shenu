defmodule Shenu.Message.Category do
  @moduledoc """
  Categorical selection/identification
  """

  use Shenu.Message

  @doc """
      iex> a = Shenu.Message.Category.new("123")
      iex> b = Shenu.Message.Category.new("456")
      iex> Shenu.Message.difference(a, b)
      1

      iex> a = Shenu.Message.Category.new("123")
      iex> b = Shenu.Message.Category.new("123")
      iex> Shenu.Message.difference(a, b)
      0
  """
  defmessage %{
    type: "string"
  }

  def schema(acceptable) when is_list(acceptable) and length(acceptable) > 0 do
    super(acceptable)
    |> Map.put("enum", acceptable)
  end
  def schema(opts) do
    super(opts)
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
