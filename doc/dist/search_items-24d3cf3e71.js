searchNodes=[{"doc":"Defines the core domain logic for validating credit cards. A credit card is given simply as a String, which may contain spaces. validate_card/1 can be used to find the type and validity of a card. card_type/1 can be used to only find the type of a card. luhn/1 can be used to only validate the digits. See CreditCardValidator.CLI module for processing credit cards in batch from stdio. Note that the card_type logic is baked into the code of this module, not externalized into a config. This should be fine, as erlang/elixir supports module updating in running applications. As new types are added, simply create additional clauses for card_type/1 and reload the module.","ref":"CreditCardValidator.html","title":"CreditCardValidator","type":"module"},{"doc":"Pattern match on the leading digits and length of a credit card number to determining the type. :AMEX -&gt; 15 digits beginning with 3,4 or 3,7 :Discover -&gt; 16 digits beginning with 6,0,1,1 :MasterCard -&gt; 16 digits beginning with 5,1-5 :Visa -&gt; 13 or 16 digits beginning with 4 :Unknown -&gt; otherwise Example iex&gt; CreditCardValidator.card_type([4,2,3,4,5,6,7,8,9,0,1,2,3]) :VISA iex&gt; CreditCardValidator.card_type([1,2,3,4,5]) :Unknown","ref":"CreditCardValidator.html#card_type/1","title":"CreditCardValidator.card_type/1","type":"function"},{"doc":"Convert a credit card number string into a list of integer digits. This is later used for pattern matching and luhn validation. Example iex&gt; CreditCardValidator.digit_list(&quot;3754 3210 987 654 321&quot;) [3, 7, 5, 4, 3, 2, 1, 0, 9, 8, 7, 6, 5, 4, 3, 2, 1]","ref":"CreditCardValidator.html#digit_list/1","title":"CreditCardValidator.digit_list/1","type":"function"},{"doc":"Removes all whitespace from a credit card number, producing a large integer string. Example iex&gt; CreditCardValidator.digit_string(&quot;3754 3210 987 654 321&quot;) &quot;37543210987654321&quot;","ref":"CreditCardValidator.html#digit_string/1","title":"CreditCardValidator.digit_string/1","type":"function"},{"doc":"Validate a credit card number using the Luhn algorithm. The input must already be split into a digit list, eg with Integer.digits or CreditCardValidator.digit_list See https://en.wikipedia.org/wiki/Luhn_algorithm for a complete description. Example iex&gt; CreditCardValidator.luhn([4,4,0,8,0,4,1,2,3,4,5,6,7,8,9,3]) :valid iex&gt; CreditCardValidator.luhn([4,4,0,8,0,4,1,2,3,4,5,6,7,8,9,4]) :invalid","ref":"CreditCardValidator.html#luhn/1","title":"CreditCardValidator.luhn/1","type":"function"},{"doc":"Given a string representing a credit card number, returns a tuple containing card type atom, card number string, and atom for validity of the card. Card type rules are defined by the card_type/1 function. Validity rules are defined by the luhn/1 function. Example iex&gt; CreditCardValidator.validate_card(&quot;3434 5678 9012 345&quot;) {:AMEX, &quot;3434 5678 9012 345&quot;, :invalid}","ref":"CreditCardValidator.html#validate_card/1","title":"CreditCardValidator.validate_card/1","type":"function"},{"doc":"","ref":"CreditCardValidator.html#t:card_number/0","title":"CreditCardValidator.card_number/0","type":"type"},{"doc":"","ref":"CreditCardValidator.html#t:card_type/0","title":"CreditCardValidator.card_type/0","type":"type"},{"doc":"","ref":"CreditCardValidator.html#t:card_validation/0","title":"CreditCardValidator.card_validation/0","type":"type"},{"doc":"","ref":"CreditCardValidator.html#t:validation/0","title":"CreditCardValidator.validation/0","type":"type"},{"doc":"Parse command line args, dispatch to worker functions to perform validation.","ref":"CreditCardValidator.CLI.html","title":"CreditCardValidator.CLI","type":"module"},{"doc":"Formats a line of output after card has been validated. Example iex&gt; CreditCardValidator.CLI.format_output({:VISA, &quot;4111111111111111&quot;, :valid}) &quot;VISA: 4111111111111111 (valid)&quot;","ref":"CreditCardValidator.CLI.html#format_output/1","title":"CreditCardValidator.CLI.format_output/1","type":"function"},{"doc":"Shows the help screen.","ref":"CreditCardValidator.CLI.html#help/0","title":"CreditCardValidator.CLI.help/0","type":"function"},{"doc":"escript application entry point. When argv is an empty list, lines from stdin will be processed. Otherwise if -h, --help or any other unrecognised flags are given help will be shown.","ref":"CreditCardValidator.CLI.html#main/1","title":"CreditCardValidator.CLI.main/1","type":"function"},{"doc":"Stream lines containing credit cards from stdin, validates each one and outputs a formatted table to stdout.","ref":"CreditCardValidator.CLI.html#process/0","title":"CreditCardValidator.CLI.process/0","type":"function"}]