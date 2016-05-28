defmodule Shenu.DateTime do
  defstruct year: 1,
            month: 1,
            day: 1,
            hour: 0,
            minute: 0,
            second: 0,
            timezone: "UTC"

  def new(opts \\ []) do
    struct(__MODULE__, opts)
  end
end

defimpl Calendar.ContainsDateTime, for: Shenu.DateTime do
  def dt_struct(%{year: y,
                  month: m,
                  day: d,
                  hour: h,
                  minute: mm,
                  second: s,
                  timezone: t}) do
    Calendar.DateTime.from_erl!({{y, m, d}, {h, mm, s}}, t)
  end
end

defimpl Shenu, for: Shenu.DateTime do
  def difference(m, m, _) do
    0
  end
  def difference(a, b, _) do
    case Calendar.DateTime.diff(a, b) do
      {:ok, secs, _, _} ->
        secs
    end
  end
end
