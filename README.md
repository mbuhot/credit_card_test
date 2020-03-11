# Credit Card Validator

Elixir library and command line application for validating credit cards.

## Build and run

Ensure Elixir is installed

```
brew update && brew install elixir
```

Use mix to build an escript binary

```
mix escript.build
./credit_card_validator <test/creditcards.txt

VISA: 4111111111111111       (valid)
VISA: 4111111111111          (invalid)
VISA: 4012888888881881       (valid)
AMEX: 378282246310005        (valid)
Discover: 6011111111111117   (valid)
MasterCard: 5105105105105100 (valid)
MasterCard: 5105105105105106 (invalid)
Unknown: 9111111111111111    (invalid)
```

## Building Docs

```
mix docs
open doc/index.html
```

[View Docs](./doc/index.html)

## Running tests

```
mix test
```

[View Tests](./test/credit_card_validator_test.exs)

## Running Dialyzer

```
mix dialyzer
```
