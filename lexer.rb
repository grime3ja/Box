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
            if has(".")
                capture
                if has_digit
                    while has_digit
                        capture
                    end
                    emit_token(:float_literal)
                else
                    raise "Expected one or more digits at index #{@index} following the decimal point"
                end
            else
                emit_token(:integer_literal)
            end
        elsif has("+")
            capture
            emit_token(:addition)
        elsif has("-")
            capture
            emit_token(:subtraction)
        elsif has("*")
            capture
            emit_token(:multiplication)
        elsif has("/")
            capture
            emit_token(:division)
        elsif has("**")
            capture
            capture
            emit_token(:exponentiation)
        elsif has("%")
            capture
            emit_token(:modulo)
        elsif has("&&")
            capture
            capture
            emit_token(:and)
        elsif has("||")
            capture
            capture
            emit_token(:or)
        elsif has("!")
            capture
            emit_token(:not)
        elsif has("&")
            capture
            emit_token(:bit_and)
        elsif has("|")
            capture
            emit_token(:bit_or)
        elsif has("^")
            capture
            emit_token(:bit_xor)
        elsif has("~")
            capture
            emit_token(:bit_not)
        elsif has("<<")
            capture
            capture
            emit_token(:bit_left)
        elsif has(">>")
            capture
            capture
            emit_token(:bit_right)
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

lex = Lexer.new("7 * 4.6 + 3 % 12")
tokens = lex.lex_string
for token in tokens
    p token  
end