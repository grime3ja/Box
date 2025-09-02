require_relative "arithmethic"
require_relative "primitive"
require_relative "translator"

# sum = Add.new(IntegerPrimitive.new(5), IntegerPrimitive.new(4))
#text = sum.visit(Translator.new())
<<<<<<< HEAD
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
=======
#neg = Negation.new(IntegerPrimitive.new(5))
#text = neg.visit(Translator.new())
#sub = Subtraction.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
#text = sub.visit(Translator.new())
#mult = Multiply.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
#text = mult.visit(Translator.new())
#div = Divide.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
#text = div.visit(Translator.new())
#mod = Modulo.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
#text = mod.visit(Translator.new())
#exp = Exponent.new(IntegerPrimitive.new(7), IntegerPrimitive.new(2))
#text = exp.visit(Translator.new())
arth = Modulo.new(Add.new(Multiply.new(IntegerPrimitive.new(7),IntegerPrimitive.new(3)),IntegerPrimitive.new(8)),IntegerPrimitive.new(12))
text = arth.visit(Translator.new())
>>>>>>> faca94338d680029f6b91c3a89847bbf7bc9ee45
p text