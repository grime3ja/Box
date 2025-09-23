require_relative 'token'

class Lexer
    def initialize(expression)
        @expression = expression
        @curr_token = ""
        @token_objects = []
        @index = 0

        @start_index = 0
    end

    def has(item)
        @expression[@index].eql?(item)
    end

    def has_digit
        @expression[@index].to_i.to_s.eql?(@expression[@index])
    end

    def capture
        @curr_token << @expression[@index]
        @index += 1
    end
    
    def emit_token(type)
        token = Token.new(type, @curr_token, @start_index, @index-1)
        @token_objects << token
        @curr_token = ""
    end

    def has_capture_emit(item, type)
        if has(item)
            capture
            emit_token(type)
        end
    end

    def lex_tokens
        @start_index = @index
        if has_digit
            while has_digit
                capture
            end
                emit_token(:integer_literal)
        elsif has("+")
            capture
            emit_token(:addition)
        else
            while has(" ")
                @index += 1
            end
        end
    end
    
    def lex_string
        while @index != @expression.length
            lex_tokens
        end
        @token_objects
    end
end

lex = Lexer.new("5 + 23")
tokens = lex.lex_string
for token in tokens
    p token  
end