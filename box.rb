require_relative "parser"
require_relative "lexer"
require_relative "evaluator"
require_relative "translator"

# string = ["a = 0", "a = a + 1", "a = a + 1"]
# string = ["x = 0", "y = 6", "x + 2"]
string = ["i = 0", "if i > 5 then i = i + 1\nprint i else print i + 2 end"]
runtime = Runtime.new
string.each do |expression|
    puts expression
    lex = Lexer.new(expression)
    tokens = lex.lex_string
    for token in tokens
        p token
    end
    puts
    parse = Parser.new(tokens)
    parsed = parse.parse
    pp parsed
    puts
    p parsed.visit(Evaluator.new(runtime))
    #puts parsed.visit(Translator.new)
end

# arithmetic_strings = ["5 + 2", "10 * 6 - 10 % 4", "~6", "2 ** 9", "45 & ---(1 + 3)", "9 << 1"]

# #parse each string, then with the parsed version evaluate the result
# arithmetic_strings.each do |expression|
#     puts expression
#     lex = Lexer.new(expression)
#     tokens = lex.lex_string
#     for token in tokens
#         p token
#     end
#     ar_parse = Parser.new(tokens)
#     ar_parsed = ar_parse.parse
#     pp ar_parsed
#     p ar_parsed.visit(Evaluator.new(Runtime.new))
#     puts
# end

# last_executed_statement_tests = ["print !!!!false", "print true || !false", "print (5 > 3) && !(2 > 8)"]

# last_executed_statement_tests.each do |expression|
#     puts expression
#     lex = Lexer.new(expression)
#     tokens = lex.lex_string
#     # for token in tokens
#     #     p token
#     # end
#     parse = Parser.new(tokens)
#     parsed = parse.parse
#     pp parsed
#     p parsed.visit(Evaluator.new(Runtime.new))
#     puts 
# end

# runtime = Runtime.new
# variables = ["x = 5", "print x + x * x", "x = 999", "print x"]
# variables.each do |expression|
#     puts expression
#     lex = Lexer.new(expression)
#     tokens = lex.lex_string
#     # for token in tokens
#     #     p token
#     # end
#     var_parse = Parser.new(tokens)
#     var_parsed = var_parse.parse
#     pp var_parsed
#     p var_parsed.visit(Evaluator.new(runtime))
# end

# invalid tests
# expression = "62=+color^!~"
# expression = "573489 | print"
# expression = "<< 2"
# puts expression
# lex = Lexer.new(expression)
# tokens = lex.lex_string
# for token in tokens
#     p token
# end
# var_parse = Parser.new(tokens)
# var_parsed = var_parse.parse
