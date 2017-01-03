defmodule CreditCardValidator.Mixfile do
  use Mix.Project

  def project do
    [app: :credit_card_validator,
     name: "Credit Card Validator",
     source_url: "https://bitbucket.org/mikebuhot/creditcard_test",
     version: "1.2.0",
     elixir: "~> 1.2",
     escript: escript_config,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # EScript Configuration
  def escript_config do
    [main_module: CreditCardValidator.CLI]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ex_doc, "~> 0.14"},
     {:earmark, "~> 1.0"}]
  end
end
