defmodule CreditCardValidator.CLI do

  import CreditCardValidator, only: [validate_card: 1, digit_string: 1]

  @moduledoc("""
    Parse command line args, dispatch to worker functions to perform validation.
  """)

  @doc("""
  escript application entry point.
  When argv is an empty list, lines from stdin will be processed.
  Otherwise if -h, --help or any other unrecognised flags are given help will be shown.
  """)
  @spec main(list(String.t)) :: :ok
  def main(argv) do
    case parse_args(argv) do
      :help -> help()
      :run -> process()
    end
  end

  @spec parse_args(list(String.t)) :: :run | :help
  defp parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean], aliases: [ h: :help ])
    case parse do
      { [], [], []} -> :run
      { [help: true], _, _ } -> :help
      _ -> :help
    end
  end

  @doc("""
  Shows the help screen.
  """)
  @spec help() :: :ok
  def help() do
    IO.puts """
      usage: credit_card_validator <inputs.txt >output.txt
      inputs.txt should be formatted with 1 credit card number per line
      outputs.txt will be filled with Type, number and validation
      """
  end

  @doc("""
  Stream lines containing credit cards from stdin,
  validates each one and outputs a formatted table to stdout.
  """)
  @spec process() :: :ok
  def process() do
    IO.stream(:stdio, :line)
    |> Stream.map(&String.strip/1)
    |> Stream.map(&validate_card/1)
    |> Stream.map(&format_output/1)
    |> Enum.each(&IO.puts/1)
  end

  @doc("""
  Formats a line of output after card has been validated.

  ## Example
      iex> CreditCardValidator.CLI.format_output({:VISA, "4111111111111111", :valid})
      "VISA: 4111111111111111       (valid)"
  """)
  @spec format_output(CreditCardValidator.card_validation) :: String.t
  def format_output({type, card, valid}) do
    "#{String.ljust("#{type}: #{digit_string(card)}", 28)} (#{valid})"
  end
end
