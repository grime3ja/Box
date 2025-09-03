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

#R-value lookup and shift
# var_z = VarPrimitive.new('z')
# assign_z = Assignment.new(var_z, IntegerPrimitive.new(2))
# rvalue_shift = BitLeft.new(VarReference.new(assign_z),IntegerPrimitive.new(3))
# text_trans = rvalue_shift.visit(Translator.new())
# text_eval = rvalue_shift.visit(Evaluator.new())
# puts text_trans
# puts text_eval

#R-value lookup and comparison
var_j = VarPrimitive.new('j')
assign_j = Assignment.new(var_j, IntegerPrimitive.new(2))
j_rvalue = VarReference.new(assign_j)
add_j = Add.new(j_rvalue, IntegerPrimitive.new(0))
rvalue_comp = Equals.new(j_rvalue,add_j)

text_trans = rvalue_comp.visit(Translator.new())
text_eval = rvalue_comp.visit(Evaluator.new())

puts text_trans
puts text_eval
