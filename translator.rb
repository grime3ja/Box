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
    def visit_subtract(leftNode, rightNode)
        "#{node.left.visit(self).value} - #{node.right.visit(self).value}"
    end

    def visit_multiply
        "#{node.left.visit(self).value} * #{node.right.visit(self).value}"
    end

    def visit_divide
        "#{node.left.visit(self).value} / #{node.right.visit(self).value}"
    end

    def visit_modulo
        "#{node.left.visit(self).value} % #{node.right.visit(self).value}"
    end

    def visit_negate
    end
end