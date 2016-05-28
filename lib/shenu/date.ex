defmodule Shenu.Date do
  defstruct year: 0,
            month: 1,
            day: 1

  def new(opts \\ []) do
    struct(__MODULE__, opts)
  end
end

defimpl Calendar.ContainsDate, for: Shenu.Date do
  def date_struct(%{year: y, month: m, day: d}) do
    Calendar.Date.from_erl!({y, m, d})
  end
end

defimpl Shenu, for: Shenu.Date do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, _) do
    Calendar.Date.diff(a, b)
  end
end
