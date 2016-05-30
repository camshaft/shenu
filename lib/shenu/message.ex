defprotocol Shenu.Message do
  def difference(a, b, method \\ :default)
end

defimpl Shenu.Message, for: Atom do
  def difference(a, a, _) do
    0
  end
  def difference(_, _, _) do
    1
  end
end
