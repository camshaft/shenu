defmodule ShenuTest do
  use ExUnit.Case, async: true

  for path <- Path.wildcard(__DIR__ <> "/../lib/shenu/message/*.ex") do
    datatype = Path.basename(path, ".ex") |> Mix.Utils.camelize()
    datatype = case datatype do
                 "Uri" -> "URI"
                 other -> other
               end
    doctest Module.concat(Shenu.Message, datatype)
  end
end
