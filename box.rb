a = IntegerPrimitive.new(5)
# p a

# Video Demonstrations

m = Multiply.new(IntegerPrimitive.new(7), IntegerPrimitive.new(4))
p m.evaluate
a = Add.new(m, 3)
p a.evaluate

# arithmetic = Modulo.new(a, 12)
# p arithmetic.evaluate