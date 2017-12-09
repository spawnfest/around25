defmodule ShapeShiftApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :shapeshift_api,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:httpoison, :poison, :logger],
      env: [api_endpoint: "https://cors.shapeshift.io"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.1"},
      {:decimal, "~> 1.4"},
      {:httpoison, "~> 0.13"},
      {:ex_doc, ">= 0.0.0", only: :dev}

    ]
  end

  defp description do
    "Elixir library for ShapeShift (shapeshift.io) exchange API."
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Darius Cupsa"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/around25/shapeshift_api"}
    ]
  end

end
