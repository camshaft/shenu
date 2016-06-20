defmodule Shenu.Mixfile do
  use Mix.Project

  def project do
    [app: :shenu,
     description: "set of utilities for parsing, validating, and diffing messages",
     version: "0.1.0",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     package: package]
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
     {:ex_json_schema, "~> 0.4.0"},
     {:geocalc, "~> 0.4"},
     {:poison, "~> 2.1.0"},
     {:the_fuzz, "~> 0.3.0"},
     {:yahoo_fx, "~> 0.2.0"},]
  end

  defp package do
    [files: ["lib", "mix.exs", "README*"],
     maintainers: ["Cameron Bytheway"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/camshaft/shenu"}]
  end
end
