defmodule Shenu.Message.PhoneNumber do
  defstruct country_code: nil,
            national_number: nil
end

defimpl Shenu.Message, for: Shenu.Message.PhoneNumber do
  def difference(m, m, _) do
    0
  end
  def difference(_, _, _) do
    1
  end
end
