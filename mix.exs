defmodule CreditCardValidator.Mixfile do
  use Mix.Project

  def project do
    [
      app: :credit_card_validator,
      name: "Credit Card Validator",
      source_url: "https://github.com/mbuhot/credit_card_test",
      version: "1.2.0",
      elixir: "~> 1.10",
      escript: escript_config(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # EScript Configuration
  def escript_config do
    [main_module: CreditCardValidator.CLI]
  end

  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ex_doc, "> 0.14.0"},
      {:earmark, "> 1.0.0"}
    ]
  end
end
