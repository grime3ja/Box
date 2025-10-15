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

    def has_letter
        @expression[@index]&.match?(/[A-Za-z]/)
    end

    def capture
        @curr_token << @expression[@index]
        @index += 1
    end

    def backtrack
        # @curr_token.slice!(-1)
        @curr_token = ""
        @index -= 1
    end
    
    def emit_token(type)
        token = Token.new(type, @curr_token, @start_index, @index-1)
        @token_objects << token
        @curr_token = ""
    end

    def lex_tokens
        @start_index = @index
        if has_digit
            while has_digit
                capture
            end
            if has(".")
                capture
                if has_digit
                    capture
                    while has_digit
                        capture
                    end
                    emit_token(:float_literal)
                else
                    backtrack
                end
            else
                emit_token(:integer_literal)
            end
        if has(".")
            capture
            emit_token(:dot)
        end
        elsif has("+")
            capture
            emit_token(:addition)
        elsif has("-")
            capture
            emit_token(:subtraction)
        elsif has("*")
            capture
            if has("*")
                capture
                emit_token(:exponentiation)
            else
                emit_token(:multiplication)
            end
        elsif has("/")
            capture
            emit_token(:division)
        elsif has("%")
            capture
            emit_token(:modulo)
        elsif has("!")
            capture
            emit_token(:not)
        elsif has("&")
            capture
            if has("&")
                capture
                emit_token(:and)
            else
                emit_token(:bit_and)
            end
        elsif has("|")
            capture
            if has("|")
                capture
                emit_token(:or)
            else
                emit_token(:bit_or)
            end
        elsif has("^")
            capture
            emit_token(:bit_xor)
        elsif has("~")
            capture
            emit_token(:bit_not)
        elsif has("<")
            capture
            if has("<")
                capture
                emit_token(:bit_left)
            elsif has("=")
                capture
                emit_token(:less_than_or_equal_to)
            else
                emit_token(:less_than)
            end
        elsif has(">")
            capture
            if has(">")
                capture
                emit_token(:bit_right)
            elsif has("=")
                capture
                emit_token(:greater_than_or_equal_to)
            else
                emit_token(:greater_than)
            end
        elsif has("=")
            capture
            if has("=")
                capture
                emit_token(:relational_equal)
            else
                emit_token(:assignment_equal)
            end
        elsif has("!")
            capture
            if has("=")
                capture
                emit_token(:relational_not_equal)
            else
                emit_token(:exclamation)
            end
        elsif has ('"')
            capture
            while !has('"')
                capture
            end
            capture
            emit_token(:quote_string)
        elsif has_letter
            while has_letter or has("_")
                capture
            end
            if @curr_token.eql?("print")
                emit_token(:print)
            elsif @curr_token.eql?("true") or @curr_token.eql?("false")
                emit_token(:boolean_literal)
            elsif @curr_token.eql?("to_f")
                emit_token(:to_f)
            elsif @curr_token.eql?("to_i")
                emit_token(:to_i)
            else 
              emit_token(:string)
            end
        elsif has(" ")
            while has(" ")
                @index += 1
            end
        elsif has ("(")
            capture
            emit_token(:left_parenthesis)
        elsif has (")")
            capture
            emit_token(:right_parenthesis)
        else
            capture
            emit_token(:unknown_token)
        end
    end
    
    def lex_string
        while @index != @expression.length
            lex_tokens
        end
        @token_objects
    end
end

# lex = Lexer.new('print "hello world"')
# lex = Lexer.new("(5 + 3 - 2 + hello)")
# tokens = lex.lex_string
# for token in tokens
#     p token
# end
