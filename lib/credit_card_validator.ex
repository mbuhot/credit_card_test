defmodule CreditCardValidator do
  @moduledoc """
  Defines the core domain logic for validating credit cards.

  A credit card is given simply as a String, which may contain spaces.

  validate_card/1 can be used to find the type and validity of a card.
  card_type/1 can be used to only find the type of a card.
  luhn/1 can be used to only validate the digits.

  See CreditCardValidator.CLI module for processing credit cards in batch from stdio.

  Note that the card_type logic is baked into the code of this module, not externalized into a config.
  This should be fine, as erlang/elixir supports module updating in running applications.
  As new types are added, simply create additional clauses for card_type/1 and reload the module.
  """

  @type card_type :: :AMEX | :Discover | :MasterCard | :VISA | :Unknown
  @type card_number :: String.t()
  @type validation :: :valid | :invalid
  @type card_validation :: {card_type, card_number, validation}

  @doc """
  Given a string representing a credit card number, returns a tuple containing
  card type atom, card number string, and atom for validity of the card.
  Card type rules are defined by the card_type/1 function.
  Validity rules are defined by the luhn/1 function.

  ## Example
      iex> CreditCardValidator.validate_card("3434 5678 9012 345")
      {:AMEX, "3434 5678 9012 345", :invalid}
  """
  @spec validate_card(card_number) :: card_validation
  def validate_card(card) do
    digits = digit_list(card)
    type = card_type(digits)
    valid = if type == :Unknown, do: :invalid, else: luhn(digits)
    {type, card, valid}
  end

  @doc """
  Convert a credit card number string into a list of integer digits.
  This is later used for pattern matching and luhn validation.

  ## Example
      iex> CreditCardValidator.digit_list("3754 3210 987 654 321")
      [3, 7, 5, 4, 3, 2, 1, 0, 9, 8, 7, 6, 5, 4, 3, 2, 1]
  """
  @spec digit_list(card_number) :: list(integer)
  def digit_list(card), do: card |> digit_string() |> String.to_integer() |> Integer.digits()

  @doc """
  Removes all whitespace from a credit card number, producing a large integer string.

  ## Example
      iex> CreditCardValidator.digit_string("3754 3210 987 654 321")
      "37543210987654321"
  """
  @spec digit_string(card_number) :: card_number
  def digit_string(card), do: card |> String.split() |> Enum.join()

  @doc """
  Pattern match on the leading digits and length of a credit card number to determining the type.
   - :AMEX -> 15 digits beginning with 3,4 or 3,7
   - :Discover -> 16 digits beginning with 6,0,1,1
   - :MasterCard -> 16 digits beginning with 5,1-5
   - :Visa -> 13 or 16 digits beginning with 4
   - :Unknown -> otherwise

  ## Example
      iex> CreditCardValidator.card_type([4,2,3,4,5,6,7,8,9,0,1,2,3])
      :VISA

      iex> CreditCardValidator.card_type([1,2,3,4,5])
      :Unknown
  """
  @spec card_type(list(integer)) :: card_type
  def card_type(card = [3, 4 | _]) when length(card) == 15, do: :AMEX
  def card_type(card = [3, 7 | _]) when length(card) == 15, do: :AMEX
  def card_type(card = [6, 0, 1, 1 | _]) when length(card) == 16, do: :Discover
  def card_type(card = [5, x | _]) when 1 <= x and x <= 5 and length(card) == 16, do: :MasterCard
  def card_type(card = [4 | _]) when length(card) == 16 or length(card) == 13, do: :VISA
  def card_type(_), do: :Unknown

  @doc """
  Validate a credit card number using the Luhn algorithm.
  The input must already be split into a digit list, eg with Integer.digits or CreditCardValidator.digit_list
  See https://en.wikipedia.org/wiki/Luhn_algorithm for a complete description.

  ## Example
      iex> CreditCardValidator.luhn([4,4,0,8,0,4,1,2,3,4,5,6,7,8,9,3])
      :valid

      iex> CreditCardValidator.luhn([4,4,0,8,0,4,1,2,3,4,5,6,7,8,9,4])
      :invalid
  """
  @spec luhn(list(integer)) :: validation
  def luhn(digits) do
    reversed = Enum.reverse(digits)

    doubled =
      reversed
      |> Enum.drop(1)
      |> Enum.take_every(2)
      |> Enum.map(&(&1 * 2))
      |> Enum.flat_map(&Integer.digits/1)

    checksum = reversed |> Enum.take_every(2) |> Enum.concat(doubled) |> Enum.sum()
    if rem(checksum, 10) == 0, do: :valid, else: :invalid
  end
end
