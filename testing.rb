require_relative "arithmethic"
require_relative "primitive"
require_relative "translator"
require_relative "evaluator"
require_relative "logical"
require_relative "bitwise"
require_relative "cast"
require_relative "variable"
require_relative "relational"
require_relative "control_flow"
runtime = Runtime.new
if_statement = If.new(GreaterThan.new(IntegerPrimitive.new(5), IntegerPrimitive.new(6)), # if 5 > 6
                        IntegerPrimitive.new(1),                                         #   1
                      BooleanPrimitive.new(true),                                        # else
                        IntegerPrimitive.new(0))                                         #   0
if_statement.visit(Evaluator.new(runtime))

puts
vp_a = VarPrimitive.new("a")
a_assign = Assignment.new(vp_a, IntegerPrimitive.new(0))
a_assign.visit(Evaluator.new(runtime))
var_ref_a = VarReference.new("a")
while_statement = While.new(LessThan.new(var_ref_a, IntegerPrimitive.new(6)),               # while a < 6
                        Assignment.new(VarPrimitive.new("a"), Add.new(var_ref_a, IntegerPrimitive.new(1))))  #   a = a + 1
                                                                                            # end
while_statement.visit(Evaluator.new(runtime))

x = Assignment.new(VarPrimitive.new("x"), IntegerPrimitive.new(0))
y = Assignment.new(VarPrimitive.new("y"), IntegerPrimitive.new(5))
x.visit(Evaluator.new(runtime))
y.visit(Evaluator.new(runtime))
for_statement = ForEach.new(VarPrimitive.new("i"), Add.new(VarReference.new("x"), IntegerPrimitive.new(2)), VarReference.new("y"), # for i in [x + 2, y]
                        PrintOut.new(VarReference.new("i")))                                                                                                                #   1
p for_statement.visit(Evaluator.new(runtime))

function = Function.new(StringPrimitive.new("foo"), VarPrimitive.new("a"), # function foo(a)
                        Return.new(IntegerPrimitive.new(5)))                                                                                #   return 5
                                                                                                                     # end
p function.visit(Translator.new)

function_call = PrintOut.new(FunctionCall.new(StringPrimitive.new("foo"), IntegerPrimitive.new(5)))
p function_call.visit(Translator.new)

### Video Examples ###

# (7 * 4 + 3) % 12
# runtime = Runtime.new
# arithmetic = Modulo.new(
#                Add.new(
#                  Multiply.new(IntegerPrimitive.new(7), IntegerPrimitive.new(4)),
#                  IntegerPrimitive.new(3)
#                ), IntegerPrimitive.new(12)
#              )

# p arithmetic.visit(Translator.new)
# p arithmetic.visit(Evaluator.new(runtime))

# a * b
# runtime = Runtime.new
# var_ref_a = VarReference.new(Assignment.new(VarPrimitive.new("a"), IntegerPrimitive.new(-4)))
# var_ref_b = VarReference.new(Assignment.new(VarPrimitive.new("b"), IntegerPrimitive.new(-3)))
# arithmetic_negation_and_rvals = Multiply.new(var_ref_a, var_ref_b)

# p arithmetic_negation_and_rvals.visit(Translator.new)
# p arithmetic_negation_and_rvals.visit(Evaluator.new(runtime))

#R-value lookup and shift
# i << 3
# runtime = Runtime.new
# var_ref_z = VarReference.new(Assignment.new(VarPrimitive.new("z"), IntegerPrimitive.new(2)))
# rvalue_shift = BitLeft.new(var_ref_z,IntegerPrimitive.new(3))
# p rvalue_shift.visit(Translator.new())
# p rvalue_shift.visit(Evaluator.new(runtime))

#R-value lookup and comparison
# j == j + 0

# runtime = Runtime.new
# var_ref_j = VarReference.new(Assignment.new(VarPrimitive.new("j"), IntegerPrimitive.new(2)))
# add_j = Add.new(var_ref_j, IntegerPrimitive.new(0))
# rvalue_comp = Equals.new(var_ref_j, add_j)

# p rvalue_comp.visit(Translator.new)
# p rvalue_comp.visit(Evaluator.new(runtime))

#Logic and comparison
# !(3.3 > 3.2)
# runtime = Runtime.new
# logic = GreaterThan.new(FloatPrimitive.new(3.3), FloatPrimitive.new(3.2))
# not_op = Not.new(logic)
# p not_op.visit(Translator.new())
# p not_op.visit(Evaluator.new(runtime))

#Double negation
# --(6 * 8)
# runtime = Runtime.new
# mult = Multiply.new(IntegerPrimitive.new(6), IntegerPrimitive.new(8))
# neg = Negation.new(Negation.new(mult))
# p neg.visit(Translator.new())
# p neg.visit(Evaluator.new(runtime))

#Bitwise op (Two's Complement)
# ~5 | ~8
# runtime = Runtime.new
# or_t = BitOr.new(
#            BitNot.new(IntegerPrimitive.new(5)), BitNot.new(IntegerPrimitive.new(8))
#        )
# text_trans = or_t.visit(Translator.new())
# text_eval = or_t.visit(Evaluator.new(runtime))
# p text_trans
# p text_eval

#Casting
# float(7) / 2
# runtime = Runtime.new
# div = Divide.new(IntToFloat.new(IntegerPrimitive.new(7)), IntegerPrimitive.new(2))
# text_trans = div.visit(Translator.new())
# text_eval = div.visit(Evaluator.new(runtime))
# p text_trans
# p text_eval

#Assignment 
# n = 9 & 3
# runtime = Runtime.new
# var_n = VarPrimitive.new('n')
# assign_n = Assignment.new(
#                var_n, BitAnd.new(IntegerPrimitive.new(9), IntegerPrimitive.new(3))
#            )
# n_rvalue = VarReference.new(assign_n)
# text_trans = assign_n.visit(Translator.new())
# text_eval = n_rvalue.visit(Evaluator.new(runtime))
# p text_trans
# p text_eval

# Block Statements

#Example 1 (Printing x variable)
# runtime = Runtime.new
# x = Assignment.new(
#         VarPrimitive.new("x"), IntegerPrimitive.new(17)
#     )
# p VarReference.new(x).visit(Translator.new)
# PrintOut.new(VarReference.new(x)).visit(Evaluator.new(runtime))

# # Example 2 (Assignment and reassignment of variables, printing data)
# runtime = Runtime.new
# count = Assignment.new(
#             VarPrimitive.new("count"), BitLeft.new(IntegerPrimitive.new(6), IntegerPrimitive.new(1))
#         )
# p count.visit(Translator.new)

# delta = Assignment.new(
#             VarPrimitive.new("delta"), IntegerPrimitive.new(3)
#         )
# p delta.visit(Translator.new)
# sum = Add.new(VarReference.new(count), VarReference.new(delta))
# count = Assignment.new(VarPrimitive.new("count"), sum)
# p count.visit(Translator.new)
# printOut = PrintOut.new(VarReference.new(count)).visit(Translator.new)
# p printOut
# PrintOut.new(VarReference.new(count)).visit(Evaluator.new(runtime))

# Example 3 (Complex print statements)
# runtime = Runtime.new
# n = Assignment.new(VarPrimitive.new("n"), IntegerPrimitive.new(18))
# # n <= 18
# p (LessThanOrEqualTo.new(VarReference.new(n), IntegerPrimitive.new(18))).visit(Translator.new)
# PrintOut.new(LessThanOrEqualTo.new(VarReference.new(n), IntegerPrimitive.new(18))).visit(Evaluator.new(runtime))
# # 13 <= n && n <= 16
# p And.new(
#         LessThanOrEqualTo.new(
#             IntegerPrimitive.new(13), VarReference.new(n)
#         ), LessThanOrEqualTo.new(
#             VarReference.new(n), IntegerPrimitive.new(16)
#         )
#     )
# .visit(Translator.new)
# PrintOut.new(
#     And.new(
#         LessThanOrEqualTo.new(
#             IntegerPrimitive.new(13), VarReference.new(n)
#         ), LessThanOrEqualTo.new(
#             VarReference.new(n), IntegerPrimitive.new(16)
#         )
#     )
# ).visit(Evaluator.new(runtime))


# -(n ** 2)
# p Negation.new(
#         Exponent.new(VarReference.new(n), IntegerPrimitive.new(2))
#     )
# .visit(Translator.new)
# PrintOut.new(
#     Negation.new(
#         Exponent.new(VarReference.new(n), IntegerPrimitive.new(2))
#     )
# ).visit(Evaluator.new(runtime))

#Typecheck checks

#Shift
# 7.5 << 2
# runtime = Runtime.new
# bit_sh = BitLeft.new(FloatPrimitive.new(7.5), IntegerPrimitive.new(2))
# text_trans = bit_sh.visit(Translator.new())
# p text_trans
# text_eval = bit_sh.visit(Evaluator.new(runtime))
# p text_eval

#Greater
# true >= 10
# runtime = Runtime.new
# great = GreaterThanOrEqualTo.new(BooleanPrimitive.new(true),IntegerPrimitive.new(10))
# text_trans = great.visit(Translator.new())
# p text_trans
# text_eval = great.visit(Evaluator.new(runtime))
# p text_eval

#Division
# "fooo" / 3
# runtime = Runtime.new
# div = Divide.new(StringPrimitive.new("fooo"),IntegerPrimitive.new(3))
# text_trans = div.visit(Translator.new())
# p text_trans
# text_eval = div.visit(Evaluator.new(runtime))
# p text_eval
