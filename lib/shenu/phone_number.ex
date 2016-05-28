defmodule Shenu.PhoneNumber do
  defstruct country_code: nil,
            national_number: nil
end

defimpl Shenu, for: Shenu.PhoneNumber do
  def difference(m, m, _) do
    0
  end
  def difference(_, _, _) do
    1
  end
end
