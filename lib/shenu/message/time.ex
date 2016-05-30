defmodule Shenu.Message.Time do
  defstruct hour: 0,
            minute: 0,
            second: 0

  def new(opts \\ []) do
    struct(__MODULE__, opts)
  end
end

defimpl Calendar.ContainsTime, for: Shenu.Message.Time do
  def time_struct(%{hour: h, minute: m, second: s}), do: Calendar.Time.from_erl!({h, m, s})
end

defimpl Shenu.Message, for: Shenu.Message.Time do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, _) do
    Calendar.Time.diff(a, b)
  end
end
