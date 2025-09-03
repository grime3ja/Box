require_relative "arithmethic"
require_relative "primitive"
require_relative "translator"
require_relative "logical"
require_relative "bitwise"
require_relative "cast"
require_relative "variable"
require_relative "relational"

### Video Examples ###

arithmetic = Modulo.new(
               Add.new(
                 Multiply.new(IntegerPrimitive.new(7), IntegerPrimitive.new(4)),
                 IntegerPrimitive.new(3)
               ), IntegerPrimitive.new(12)
             )

text = "#{arithmetic.visit(Translator.new)} = #{arithmetic.visit(Evaluator.new)}"
p text

a = Assignment.new(VarPrimitive.new('a'), IntegerPrimitive.new(-4))
b = Assignment.new(VarPrimitive.new('b'), IntegerPrimitive.new(-3))
arithmetic_negation_and_rvals = Multiply.new(VarReference.new(a), VarReference.new(b))
text = "#{arithmetic_negation_and_rvals.visit(Translator.new)} = #{arithmetic_negation_and_rvals.visit(Evaluator.new)}"
p text
