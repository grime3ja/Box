require_relative 'lexer'
require_relative 'relational'
require_relative 'arithmethic'
require_relative 'bitwise'
require_relative 'cast'
require_relative 'logical'
require_relative 'primitive'
require_relative 'variable'
require_relative 'control_flow'
class Parser
  def initialize(tokens)
    @tokens = tokens
    @i = 0
  end

  def curr_token
    @tokens[@i]
  end

  def has(type)
    @i < @tokens.size && @tokens[@i].type == type
  end

  def expect(type)
    if has(type)
      advance
    else
      raise "Expected token #{type} at index #{@i}"
    end
  end

  def advance
    @i += 1 unless @i == @tokens.size
  end

  def parse
    result = parse_lvl9
  end
  def parse_lvl9
    block = []
    elsee = false
    else_block = []
    if has(:if)
      advance
      condition = parse_lvl8
      if has(:then)
        loop do
          advance
          statement = parse_lvl8
          block << statement
          break if has(:end) || has(:else)
        end
      end
      if has(:else)
        elsee = BooleanPrimitive.new(true)
        loop do
          advance
          statement = parse_lvl8
          else_block << statement
          break if has(:end)
        end
      end
      If.new(condition,block,elsee,else_block)
    else
      parse_lvl8
    end
  end
  def parse_lvl8
    if has(:print)
      advance
      expression = parse_lvl7
      return PrintOut.new(expression)
    else
      parse_lvl7
    end
  end
  def parse_lvl7
    left = parse_lvl6
    if has(:assignment_equal)
      advance
      right = parse_lvl6
      return Assignment.new(left,right)
    end
    left
  end
  def parse_lvl6
    left = parse_lvl5
    loop do 
      case curr_token&.type
      when :addition
        advance
        right = parse_lvl5
        left = Add.new(left,right)
      when :subtraction
        advance
        right = parse_lvl5
        left = Subtraction.new(left,right)
      else
        break
      end
    end
  left
  end

  def parse_lvl5
    left = parse_lvl4
    loop do 
      case curr_token&.type
      when :multiplication
        advance
        right = parse_lvl4
        left = Multiply.new(left,right)
      when :division
        advance
        right = parse_lvl4
        left = Divide.new(left,right)
      when :modulo
        advance
        right = parse_lvl4
        left = Modulo.new(left,right)
      when :exponentiation
        advance
        right = parse_lvl4
        left = Exponent.new(left,right)
      else
        break
      end
    end
    left
  end
  def parse_lvl4
    left = parse_lvl3
    loop do
      case curr_token&.type
      when :and
        advance
        right = parse_lvl3
        left = And.new(left,right)
      when :or
        advance
        right = parse_lvl3
        left = Or.new(left,right)
      else
        break
      end
    end
    left
  end

  def parse_lvl3
    left = parse_lvl2
    loop do
      case curr_token&.type
      when :relational_equal
        advance
        right = parse_lvl2
        left = Equals.new(left,right)
      when :relational_not_equal
        advance
        right = parse_lvl2
        left = NotEquals.new(left,right)
      when :less_than
        advance
        right = parse_lvl2
        left = LessThan.new(left,right)
      when :less_than_or_equal_to
        advance
        right = parse_lvl2
        left = LessThanOrEqualTo.new(left, right)
      when :greater_than
        advance
        right = parse_lvl2
        left = GreaterThan.new(left,right)
      when :greater_than_or_equal_to
        advance
        right = parse_lvl2
        left = GreaterThanOrEqualTo.new(left,right)
      else
        break
      end
    end
    left
  end

  def parse_lvl2
    left = parse_lvl1
    loop do
      case curr_token&.type
      when :bit_left
        advance
        right = parse_lvl1
        left = BitLeft.new(left,right)
      when :bit_right
        advance
        right = parse_lvl1
        left = BitRight.new(left,right)
      when :bit_or
        advance
        right = parse_lvl1
        left = BitOr.new(left,right)
      when :bit_and
        advance
        right = parse_lvl1
        left = BitAnd.new(left,right)
      when :bit_xor
        advance
        right = parse_lvl1
        left = BitXor.new(left,right)
      else
        break
      end
    end
    left
  end

  def parse_lvl1
    left = parse_lvl0
    while has(:dot)
      advance
      if has(:to_i)
        advance
        left = FloatToInt.new(left)
      elsif has(:to_f)
        advance
        left = IntToFloat.new(left)
      else
        raise "Unknown method at index #{@i}, your options are float to int (to_i) and int to float (to_f)"
      end
    end
    left
  end
  def parse_lvl0
    if has(:not)
      advance
      operand = parse_lvl0
      return Not.new(operand)
    elsif has(:bit_not)
      advance
      op = parse_lvl0
      return BitNot.new(op)
    elsif has(:subtraction)
      advance
      op = parse_lvl0
      return Negation.new(op)
    else
      parse_lvlN
    end
  end

  def parse_lvlN
    if has(:left_parenthesis)
      advance
      exp = parse_lvl6
      expect(:right_parenthesis)
      return exp
    elsif has(:integer_literal)
      token = curr_token
      advance
      return IntegerPrimitive.new(token.text.to_i)
    elsif has(:float_literal)
      token = curr_token
      advance
      return FloatPrimitive.new(token.text.to_f)
    elsif has(:boolean_literal)
      token = curr_token
      advance
      return BooleanPrimitive.new(token.text == "true")
    elsif has(:quote_string)
      token = curr_token
      advance
      return StringPrimitive.new(token.text)
    elsif has(:string) || has(:variable)
      token = curr_token
      advance
      if (has(:assignment_equal))
        return VarPrimitive.new(token.text)
      end
      return VarReference.new(token.text)
    else
      t = @tokens[@i].type
      error = "Unknown type #{t} at index #{@i}"
      number_errors = [:addition, :multiplication, :division, :subtraction]
      bitwise_errors = [:bit_and, :bit_left, :bit_right, :bit_not, :bit_xor]
      relational_errors = [:less_than, :less_than_or_equal_to, :greater_than, :greater_than_or_equal_to, :relational_equal, :relational_not_equal]
      if number_errors.include?(t)
        raise "#{error}, expected variable or number values surrounded by an arithmetic operator"
      elsif bitwise_errors.include?(t)
        raise "#{error}, expected a variable or integer values surrounded by a bitwise operator"
      elsif relational_errors.include?(t)
        raise "#{error}, expected variable or number values surrounded by a relational boolean operator"
      elsif t.eql?(:print)
        raise "#{error}, expected to be in the format of print *what you would like to print*"
      else
        raise "Error message has not been added yet, please request a fix for: #{error}"
      end
    end
  end
end

