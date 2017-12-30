defmodule Clone.Mixfile do
  use Mix.Project

  def project do
    [
      app: :clone,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      docs: docs(),
      escript: escript(),
      preferred_cli_env: [espec: :test]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "> 0.0.0", only: :dev, runtime: false},
      {:version_tasks, "~> 0.10", only: :dev},
      {:espec, "~> 1.5", only: :test}
    ]
  end

  def docs do
    [
      extras: ["README.md", "LICENSE.md"],
      main: "Clone"
    ]
  end

  defp escript do
    [
      main_module: Clone.CLI
    ]
  end
end
