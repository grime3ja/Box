require_relative "arithmethic"
require_relative "primitive"
require_relative "translator"

sum = Add.new(IntegerPrimitive.new(5), IntegerPrimitive.new(4))
text = sum.visit(Translator.new())
p text