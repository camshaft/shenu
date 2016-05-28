defmodule Hieroglyph.Mixfile do
  use Mix.Project

  def project do
    [app: :hieroglyph,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [
      :calendar,
      :logger,
      :yahoo_fx
    ]]
  end

  defp deps do
    [{:calendar, "~> 0.14.0"},
     {:color_utils, "~> 0.2.0"},
     {:geocalc, "~> 0.4"},
     {:the_fuzz, "~> 0.3.0"},
     {:yahoo_fx, "~> 0.2.0"},]
  end
end
