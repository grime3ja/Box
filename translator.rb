class Translator
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
        "#{node.left.visit(self)} + #{node.right.visit(self)}"
    end

    def visit_subtract(leftNode, rightNode)
        "#{node.left.visit(self)} - #{node.right.visit(self)}"
    end

    def visit_multiply
        "#{node.left.visit(self)} * #{node.right.visit(self)}"
    end

    def visit_divide
        "#{node.left.visit(self)} / #{node.right.visit(self)}"
    end

    def visit_modulo
        "#{node.left.visit(self)} % #{node.right.visit(self)}"
    end

    def visit_exponent
        "#{node.left.visit(self)} ^ #{node.right.visit(self)}"
    end

    def visit_negate
    end
end