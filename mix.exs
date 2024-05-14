defmodule Testchats.MixProject do
  use Mix.Project

  def project do
    [
      app: :testchats,
      version: "0.1.0",
      elixir: "~> 1.16",
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
      {:n2o, "~> 10.12.3"},
      {:kvs, "~> 10.8.2"},
      {:nitro, "~> 8.2.4"}
    ]
  end
end
