defprotocol Shenu do
  def difference(a, b, method \\ :default)
end

defimpl Shenu, for: Atom do
  def difference(a, a, _) do
    0
  end
  def difference(_, _, _) do
    1
  end
end
