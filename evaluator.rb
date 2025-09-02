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

    # still need to do this part
    def visit_negate(node)
        value = node.value

        -value
    end
end