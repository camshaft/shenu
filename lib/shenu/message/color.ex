defmodule Shenu.Message.Color do
  @moduledoc """
  Struct representing RGB colors

      iex> a = Shenu.Message.Color.new(r: 20, g: 40, b: 50)
      iex> b = Shenu.Message.Color.new(r: 120, g: 10, b: 70)
      iex> Shenu.Message.difference(a, b)
      42.2736269661734
  """

  defstruct r: 0,
            g: 0,
            b: 0

  def new(opts \\ [])
  def new(rgb) when is_binary(rgb) do
    ## TODO
  end
  def new(opts) do
    %__MODULE__{r: opts[:r] || 0,
                g: opts[:g] || 0,
                b: opts[:b] || 0}
  end
end

defimpl Shenu.Message, for: Shenu.Message.Color do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, :default) do
    difference(a, b, :cie94)
  end
  def difference(a, b, :cie94) do
    ColorUtils.distance(convert(a), convert(b))
  end

  defp convert(%{r: r, g: g, b: b}) do
    %ColorUtils.RGB{red: r, green: g, blue: b}
  end
end
