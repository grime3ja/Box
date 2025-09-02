class Translator
    def visit_integer(node)
        node
    end

    def visit_float(node)
        node
    end

    def visit_boolean(node)
        node
    end

    def visit_string(node)
        node
    end

    def visit_null(node)
        node
    end

    def visit_add(node)
        "#{node.left.visit(self).value} + #{node.right.visit(self).value}"
    end

    def visit_subtract(node)
        "#{node.left.visit(self).value} - #{node.right.visit(self).value}"
    end

    def visit_multiply(node)
        "#{node.left.visit(self).value} * #{node.right.visit(self).value}"
    end

    def visit_divide(node)
        "#{node.left.visit(self).value} / #{node.right.visit(self).value}"
    end

    def visit_modulo(node)
        "#{node.left.visit(self).value} % #{node.right.visit(self).value}"
    end

    def visit_exponent(node)
        "#{node.left.visit(self).value} ^ #{node.right.visit(self).value}"
    end

    def visit_negate(node)
        "-#{node.value.visit(self).value}"
    end
end