defmodule Duper.MixProject do
  use Mix.Project

  def project do
    [
      app: :duper,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :crypto],
      mod: {Duper.Application, []},
      env: [path: "C:\\Users\\chris\\IdeaProjects\\", woker: 5],
      registered: [
        Duper.Results,
        Duper.PathFinder,
        Duper.WorkerSupervisor,
        Duper.Gatherer,
        Duper.Worker
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      dir_walker: "~> 0.0.7"
    ]
  end
end
