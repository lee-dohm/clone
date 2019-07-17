defmodule Clone.Mixfile do
  use Mix.Project

  def project do
    [
      app: :clone,
      name: "Clone for GitHub",
      homepage_url: "https://github.com/lee-dohm/clone",
      source_url: "https://github.com/lee-dohm/clone",
      version: "1.0.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      escript: escript()
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
      {:version_tasks, "~> 0.10", only: :dev}
    ]
  end

  defp docs do
    [
      extras: [
        "README.md",
        "CONTRIBUTING.md",
        "CODE_OF_CONDUCT.md": [
          filename: "code_of_conduct",
          title: "Code of Conduct"
        ],
        "LICENSE.md": [
          filename: "license",
          title: "License"
        ]
      ],
      main: "readme"
    ]
  end

  defp escript do
    [
      main_module: Clone.CLI
    ]
  end
end
