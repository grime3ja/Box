require_relative "arithmethic"
require_relative "primitive"
require_relative "translator"
require_relative "evaluator"
require_relative "logical"
require_relative "bitwise"
require_relative "cast"
require_relative "variable"
require_relative "relational"

### Video Examples ###

# (7 * 4 + 3) % 12
arithmetic = Modulo.new(
               Add.new(
                 Multiply.new(IntegerPrimitive.new(7), IntegerPrimitive.new(4)),
                 IntegerPrimitive.new(3)
               ), IntegerPrimitive.new(12)
             )

text = "#{arithmetic.visit(Translator.new)} = #{arithmetic.visit(Evaluator.new)}"
p text

# a * b
a = Assignment.new(
        VarPrimitive.new('a'), IntegerPrimitive.new(-4)
    )
b = Assignment.new(
        VarPrimitive.new('b'), IntegerPrimitive.new(-3)
    )
arithmetic_negation_and_rvals = Multiply.new(VarReference.new(a), VarReference.new(b))
text = "#{arithmetic_negation_and_rvals.visit(Translator.new)} = #{arithmetic_negation_and_rvals.visit(Evaluator.new)}"
p text

#R-value lookup and shift
# i << 3
var_z = VarPrimitive.new('z')
assign_z = Assignment.new(var_z, IntegerPrimitive.new(2))
rvalue_shift = BitLeft.new(VarReference.new(assign_z),IntegerPrimitive.new(3))
text_trans = rvalue_shift.visit(Translator.new())
text_eval = rvalue_shift.visit(Evaluator.new())
puts text_trans
puts text_eval

#R-value lookup and comparison
# j == j + 0
var_j = VarPrimitive.new('j')
assign_j = Assignment.new(var_j, IntegerPrimitive.new(2))
j_rvalue = VarReference.new(assign_j)
add_j = Add.new(j_rvalue, IntegerPrimitive.new(0))
rvalue_comp = Equals.new(j_rvalue,add_j)

text_trans = rvalue_comp.visit(Translator.new())
text_eval = rvalue_comp.visit(Evaluator.new())

puts text_trans
puts text_eval

#Logic and comparison
# !(3.3 > 3.2)
logic = GreaterThan.new(FloatPrimitive.new(3.3), FloatPrimitive.new(3.2))
not_op = Not.new(logic)
text_trans = not_op.visit(Translator.new())
text_eval = not_op.visit(Evaluator.new())
puts text_trans
puts text_eval

#Double negation
# --(6 * 8)
mult = Multiply.new(IntegerPrimitive.new(6), IntegerPrimitive.new(8))
neg = Negation.new(Negation.new(mult))
text_trans = neg.visit(Translator.new())
text_eval = neg.visit(Evaluator.new())
puts text_trans
puts text_eval

#Bitwise op (Two's Complement)
# ~5 | ~8
or_t = BitOr.new(
           BitNot.new(IntegerPrimitive.new(5)), BitNot.new(IntegerPrimitive.new(8))
       )
text_trans = or_t.visit(Translator.new())
text_eval = or_t.visit(Evaluator.new())
puts text_trans
puts text_eval

#Casting
# float(7) / 2
div = Divide.new(IntToFloat.new(IntegerPrimitive.new(7)), IntegerPrimitive.new(2))
text_trans = div.visit(Translator.new())
text_eval = div.visit(Evaluator.new())
puts text_trans
puts text_eval

#Assignment 
# n = 9 & 3
var_n = VarPrimitive.new('n')
assign_n = Assignment.new(
               var_n, BitAnd.new(IntegerPrimitive.new(9), IntegerPrimitive.new(3))
           )
n_rvalue = VarReference.new(assign_n)
text_trans = assign_n.visit(Translator.new())
text_eval = n_rvalue.visit(Evaluator.new())
puts text_trans
puts text_eval

# Block Statements

# Example 1 (Printing x variable)
x = Assignment.new(
        VarPrimitive.new("x"), IntegerPrimitive.new(17)
    )
PrintOut.new(VarReference.new(x)).visit(Evaluator.new)

# Example 2 (Assignment and reassignment of variables, printing data)
count = Assignment.new(
            VarPrimitive.new("count"), BitLeft.new(IntegerPrimitive.new(6), IntegerPrimitive.new(1))
        )
p count.visit(Translator.new)

delta = Assignment.new(
            VarPrimitive.new("delta"), IntegerPrimitive.new(3)
        )
p delta.visit(Translator.new)
sum = Add.new(VarReference.new(count), VarReference.new(delta))
count = Assignment.new(VarPrimitive.new("count"), sum)
p count.visit(Translator.new)
printOut = PrintOut.new(VarReference.new(count)).visit(Translator.new)
p printOut
PrintOut.new(VarReference.new(count)).visit(Evaluator.new)

# Example 3 (Complex print statements)
n = Assignment.new(VarPrimitive.new("n"), IntegerPrimitive.new(18))
# n <= 18
PrintOut.new(LessThanOrEqualTo.new(VarReference.new(n), IntegerPrimitive.new(18))).visit(Evaluator.new)
# 13 <= n && n <= 16
PrintOut.new(
    And.new(
        LessThanOrEqualTo.new(
            IntegerPrimitive.new(13), VarReference.new(n)
        ), LessThanOrEqualTo.new(
            VarReference.new(n), IntegerPrimitive.new(16)
        )
    )
).visit(Evaluator.new)

# -(n ** 2)
PrintOut.new(
    Negation.new(
        Exponent.new(VarReference.new(n), IntegerPrimitive.new(2))
    )
).visit(Evaluator.new)

#Typecheck checks

#Shift
# 7.5 << 2
bit_sh = BitLeft.new(FloatPrimitive.new(7.5), IntegerPrimitive.new(2))
text_trans = bit_sh.visit(Translator.new())
puts text_trans
# text_eval = bit_sh.visit(Evaluator.new())
# puts text_eval

#Greater
# true >= 10
great = GreaterThanOrEqualTo.new(BooleanPrimitive.new(true),IntegerPrimitive.new(10))
text_trans = great.visit(Translator.new())
puts text_trans
# text_eval = great.visit(Evaluator.new())
# puts text_eval

#Division
# "fooo" / 3
div = Divide.new(StringPrimitive.new("fooo"),IntegerPrimitive.new(3))
text_trans = div.visit(Translator.new())
puts text_trans
# text_eval = div.visit(Evaluator.new())
# puts text_eval
