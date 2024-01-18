defmodule InMemoryDataStore.MixProject do
  use Mix.Project

  def project do
    [
      app: :in_memory_data_store,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:todo, in_umbrella: true},
      {:create_todo, in_umbrella: true},
      {:complete_todo, in_umbrella: true},
      {:list_todos, in_umbrella: true}
    ]
  end
end
