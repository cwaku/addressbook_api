defmodule Addressbook.MixProject do
  use Mix.Project

  def project do
    [
      app: :addressbook,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # default_cli_flags: [:config, "config/runtime.dev.exs"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Addressbook.Application, []}
    ]
  end

  defp aliases do
    [
      "ecto.*": ["ecto", "--repo", "Addressbook.Repo"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:plug_cowboy, "~> 2.5"},
      {:cowboy, "~> 2.9"},
      {:plug, "~> 1.13"},
      {:poison, "~> 5.0"},
      {:ecto, "~> 3.9"},
      {:ecto_sql, "~> 3.8"},
      {:postgrex, "~> 0.16"},
      {:httpoison, "~> 1.8"}
    ]
  end
end
