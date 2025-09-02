require_relative "arithmethic"
require_relative "primitive"
require_relative "translator"

# sum = Add.new(IntegerPrimitive.new(5), IntegerPrimitive.new(4))
#text = sum.visit(Translator.new())
# neg = Negation.new(IntegerPrimitive.new(5))
# text = neg.visit(Translator.new())
# sub = Subtraction.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
# text = sub.visit(Translator.new())
# mult = Multiply.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
# text = mult.visit(Translator.new())
# div = Divide.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
# text = div.visit(Translator.new())
# mod = Modulo.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
# text = mod.visit(Translator.new())
exp = Exponent.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
text = exp.visit(Translator.new())
p text