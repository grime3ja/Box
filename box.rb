require_relative "parser"
require_relative "lexer"
require_relative "evaluator"

arithmetic_strings = ["5 + 2", "10 * 6 - 10 % 4", "~6", "2 ** 9", "45 & ---(1 + 3)", "9 << 1"]

# parse each string, then with the parsed version evaluate the result
# arithmetic_strings.each do |expression|
#     puts expression
#     parse = Parser.new(Lexer.new(expression).lex_string)
#     parsed =  parse.parse
#     pp parsed
#     p parsed.visit(Evaluator.new(Runtime.new))
#     puts
# end

last_executed_statement_tests = ["!!!!false", "true || false", "(5 > 3) && !(2 > 8)"]
last_executed_statement_tests.each do |expression|
    puts expression
    lex = Lexer.new(expression)
    tokens = lex.lex_string
    for token in tokens
        p token
    end
    parse = Parser.new(tokens)
    parsed =  parse.parse
    pp parsed
    p parsed.visit(Evaluator.new(Runtime.new))
    puts 
end