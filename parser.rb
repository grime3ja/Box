require_relative 'lexer'
require_relative 'relational.rb'
class Parser
  def initialize(tokens)
    @tokens = tokens
    @i = 0
  end
  def has(type)
    @i < @tokens.size && @tokens[@i].type == type
  end
  def advance
    token = @tokens[@i]
    @i += 1
    token
  end
  def parse
    while @i < @tokens.size
      if has(:integer_literal)
        left_token = advance
        left_value = left_token.text.to_i
        if has(:less_than_or_equal_to)
          advance
        if has(:integer_literal)
          right_token = advance
          right_value = right_token.text.to_i
          
          return LessThanOrEqualTo.new(left_value, right_value)
        else
          raise "error: no number after operator"
        end
      else
        raise "error: no operator after first number"
      end 
    end
  end
end
end
lexer = Lexer.new("5 <= 32")
token = lexer.lex_string
parser = Parser.new(token)
pp parser.parse