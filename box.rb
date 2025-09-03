require_relative "arithmethic"
require_relative "primitive"
require_relative "translator"
require_relative "logical"
require_relative "bitwise"
require_relative "cast"
require_relative "relational"

# sum = Add.new(IntegerPrimitive.new(5), IntegerPrimitive.new(4))
#text = sum.visit(Translator.new())
neg = Negation.new(IntegerPrimitive.new(5))
text = neg.visit(Evaluator.new())
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

eq = Equals.new(IntegerPrimitive.new(4), IntegerPrimitive.new(3))
text = eq.visit(Translator.new())
p text
text = eq.visit(Evaluator.new())
p text
# int_test = IntToFloat.new(BooleanPrimitive.new(5))
# text = int_test.visit(Translator.new())
# p text