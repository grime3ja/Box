class Evaluator
    def visit_integer(node)
        node.value
    end

    def visit_float(node)
        node.value
    end

    def visit_boolean(node)
        node.value
    end

    def visit_string(node)
        node.value
    end

    def visit_null(node)
        node.value
    end

    def visit_add(node)
        leftPrimitive = node.left.visit(self)
        rightPrimitive = node.right.visit(self)

        leftPrimitive + rightPrimitive
    end

    def visit_subtract(node)
        leftPrimitive = node.left.visit(self)
        rightPrimitive = node.right.visit(self)

        leftPrimitive - rightPrimitive
    end

    def visit_multiply(node)
        leftPrimitive = node.left.visit(self)
        rightPrimitive = node.right.visit(self)

        leftPrimitive * rightPrimitive
    end

    def visit_divide(node)
        leftPrimitive = node.left.visit(self)
        rightPrimitive = node.right.visit(self)

        leftPrimitive / rightPrimitive
    end

    def visit_modulo(node)
        leftPrimitive = node.left.visit(self)
        rightPrimitive = node.right.visit(self)

        leftPrimitive % rightPrimitive
    end

    def visit_exponent(node)
        leftPrimitive = node.left.visit(self)
        rightPrimitive = node.right.visit(self)

        leftPrimitive ** rightPrimitive
    end

    
    def visit_negate(node)
        value = node.value.visit(self)
         -value
    end

    def visit_and(node)
        leftValue = node.left.visit(self)
        rightValue = node.right.visit(self)

        leftValue && rightValue
    end

    def visit_or(node)
        leftValue = node.left.visit(self)
        rightValue = node.right.visit(self)

        leftValue || rightValue
    end

    def visit_not(node)
        value = node.value.visit(self)

        !value
    end
    def visit_bit_and(node)
        leftValue = node.left.visit(self)
        rightValue = node.right.visit(self)

        leftValue & rightValue
    end

    def visit_bit_or(node)
        leftValue = node.left.visit(self)
        rightValue = node.right.visit(self)

        leftValue | rightValue
    end

    def visit_bit_xor(node)
        leftValue = node.left.visit(self)
        rightValue = node.right.visit(self)

        leftValue ^ rightValue
    end

    def visit_bit_not(node)
         value = node.value.visit(self)
         ~value
    end

    def visit_bit_left(node)
        leftValue = node.left.visit(self)
        rightValue = node.right.visit(self)

        leftValue << rightValue
    end

    def visit_bit_right(node)
        leftValue = node.left.visit(self)
        rightValue = node.right.visit(self)

        leftValue >> rightValue
    end
    def visit_float_to_int(node)
        value = node.value.visit(self)

        value.to_i
    end

    def visit_int_to_float(node)
        value = node.value.visit(self)

        value.to_f
    end

    def visit_equals(node)
        leftValue = node.left.visit(self)
        rightValue = node.right.visit(self)

        leftValue == rightValue
    end

    def visit_not_equals(node)
        leftValue = node.left.visit(self)
        rightValue = node.right.visit(self)

        leftValue != rightValue
    end

    def visit_less_than(node)
        leftValue = node.left.visit(self)
        rightValue = node.right.visit(self)

        leftValue < rightValue
    end

    def visit_less_than_or_equal_to(node)
        leftValue = node.left.visit(self)
        rightValue = node.right.visit(self)

        leftValue <= rightValue
    end

    def visit_greater_than(node)
        leftValue = node.left.visit(self)
        rightValue = node.right.visit(self)

        leftValue > rightValue
    end

    def visit_greater_than_or_equal_to(node)
        leftValue = node.left.visit(self)
        rightValue = node.right.visit(self)

        leftValue >= rightValue
    end
end