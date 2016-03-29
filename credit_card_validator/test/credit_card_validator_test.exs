defmodule CreditCardValidatorTest do
  use ExUnit.Case
  import CreditCardValidator, only: [validate_card: 1]
  import ExUnit.CaptureIO, only: [capture_io: 2]

  doctest CreditCardValidator
  doctest CreditCardValidator.CLI

  test "Card beginning with 34 is AMEX" do
    assert {:AMEX, "343456789012345", :invalid} == validate_card("343456789012345")
  end

  test "Card beginning with 37 is AMEX" do
    assert {:AMEX, "373456789012345", :invalid} == validate_card("373456789012345")
  end

  test "AMEX card may contain blanks" do
    assert {:AMEX, "3734 567 890 123 45", :invalid} == validate_card("3734 567 890 123 45")
  end

  test "AMEX card must have 15 digits - too few" do
    assert {:Unknown, "343456", :invalid} == validate_card("343456")
    assert {:Unknown, "37345678901234567",:invalid} == validate_card("37345678901234567")
  end

  test "Discover card must have 16 digits starting with 6601" do
    assert {:Discover, "6011 1234 5678 1234", :invalid} == validate_card("6011 1234 5678 1234")
    assert {:Discover, "6011111111111117", :valid} == validate_card("6011111111111117")
    assert {:Unknown, "6011 1234", :invalid} == validate_card("6011 1234")
  end

  test "MasterCard must have 16 digits starting with 51-51" do
    assert {:MasterCard, "5134 5678 9012 3456", :invalid} == validate_card("5134 5678 9012 3456")
    assert {:MasterCard, "5334 5678 9012 3456", :invalid} == validate_card("5334 5678 9012 3456")
    assert {:MasterCard, "5534 5678 9012 3456", :invalid} == validate_card("5534 5678 9012 3456")
    assert {:Unknown, "5534 5678 9012", :invalid} == validate_card("5534 5678 9012")
  end

  test "Visa may have 13 or 16 digits starting with 4" do
    assert {:VISA, "4408 0412 3456 7893", :valid} == validate_card("4408 0412 3456 7893")
    assert {:VISA, "4417 1234 5678 9112", :invalid} == validate_card("4417 1234 5678 9112")
    assert {:VISA, "4134 5678 90123", :invalid} == validate_card("4134 5678 90123")
    assert {:Unknown, "4134 5678 9012 32", :invalid} == validate_card("4134 5678 9012 32")
    assert {:Unknown, "4134 5678 9012 323", :invalid} == validate_card("4134 5678 9012 323")
  end

  test "Integration test" do
    input = File.read!("test/creditcards.txt")
    expected = File.read!("test/expected_output.txt")
    output = capture_io(input, fn () -> CreditCardValidator.CLI.main([]) end)
    assert expected == output
  end
end
