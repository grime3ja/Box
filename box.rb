require_relative "arithmethic"
require_relative "primitive"
require_relative "translator"
require_relative "logical"
require_relative "bitwise"
require_relative "cast"
require_relative "variable"
require_relative "relational"

# sum = Add.new(IntegerPrimitive.new(5), IntegerPrimitive.new(4))
#text = sum.visit(Translator.new())
# neg = Negation.new((Negation.new(IntegerPrimitive.new(5))))
# text = neg.visit(Translator.new())
# sub = Subtraction.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
#text = sub.visit(Translator.new())
# mult = Multiply.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
#text = mult.visit(Translator.new())
# div = Divide.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
#text = div.visit(Translator.new())
# mod = Modulo.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
#text = mod.visit(Translator.new())
# exp = Exponent.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
#text = exp.visit(Translator.new())
# arth = Modulo.new(Add.new(Multiply.new(IntegerPrimitive.new(7),IntegerPrimitive.new(3)),IntegerPrimitive.new(8)),IntegerPrimitive.new(12))
# text = arth.visit(Translator.new())
# p text

# arth = Add.new(Add.new(Add.new(IntegerPrimitive.new(5), IntegerPrimitive.new(3)), IntegerPrimitive.new(2)), IntegerPrimitive.new(1))
# text = arth.visit(Translator.new) + " =  #{arth.visit(Evaluator.new)}"

# p text

# and_test = And.new(BooleanPrimitive.new(true), BooleanPrimitive.new(false))
# text = and_test.visit(Evaluator.new())
# or_test = Or.new(BooleanPrimitive.new(true), BooleanPrimitive.new(false))
# text = or_test.visit(Evaluator.new())
# not_test = Not.new(BooleanPrimitive.new(true))
# text = not_test.visit(Evaluator.new())
# bit_x = BitRight.new(IntegerPrimitive.new(9), IntegerPrimitive.new(2))
# text = bit_x.visit(Evaluator.new())

# eq = Equals.new(IntegerPrimitive.new(4), IntegerPrimitive.new(3))
# text = eq.visit(Translator.new())
# p text
# text = eq.visit(Evaluator.new())
# p text
# int_test = IntToFloat.new(BooleanPrimitive.new(5))
# text = int_test.visit(Translator.new())
# p text

# var_x = VarPrimitive.new("x")
# assign_test = Assignment.new(var_x, IntegerPrimitive.new(5))
# r_test = VarReference.new(assign_test)
# # text = r_test.visit(Translator.new())

# var_y = VarPrimitive.new('y')
# assign_y = Assignment.new(var_y, IntegerPrimitive.new(3))
# y_test = VarReference.new(assign_y)
# sum = Multiply.new(r_test, y_test)
# print_t = PrintOut.new(sum)
# print_t.visit(Evaluator.new())

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

