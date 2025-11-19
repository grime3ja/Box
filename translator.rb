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

    def visit_var(node)
        node.value
    end

    def visit_add(node)
        "(#{node.left.visit(self)} + #{node.right.visit(self)})"
    end

    def visit_subtract(node)
        "#{node.left.visit(self)} - #{node.right.visit(self)}"
    end

    def visit_multiply(node)
        "(#{node.left.visit(self)} * #{node.right.visit(self)})"
    end

    def visit_divide(node)
        "#{node.left.visit(self)} / #{node.right.visit(self)}"
    end

    def visit_modulo(node)
        "#{node.left.visit(self)} % #{node.right.visit(self)}"
    end

    def visit_exponent(node)
        "#{node.left.visit(self)} ** #{node.right.visit(self)}"
    end

    def visit_negate(node)
        "-#{node.value.visit(self)}"
    end

    def visit_and(node)
        "#{node.left.visit(self)} && #{node.right.visit(self)}"
    end
    
    def visit_or(node)
        "#{node.left.visit(self)} || #{node.right.visit(self)}"
    end

    def visit_not(node)
        "!(#{node.value.visit(self)})"
    end

    def visit_bit_and(node)
        "#{node.left.visit(self)} & #{node.right.visit(self)}"
    end

    def visit_bit_or(node)
        "#{node.left.visit(self)} | #{node.right.visit(self)}"
    end

    def visit_bit_xor(node)
        "#{node.left.visit(self)} ^ #{node.right.visit(self)}"
    end

    def visit_bit_not(node)
        "~#{node.value.visit(self)}"
    end

    def visit_bit_left(node)
        "#{node.left.visit(self)} << #{node.right.visit(self)}"
    end

    def visit_bit_right(node)
        "#{node.left.visit(self)} >> #{node.right.visit(self)}"
    end
    #this is C syntax dont know what ruby looks like
    def visit_float_to_int(node)
        "#{node.value.visit(self)}.to_i"
    end

    def visit_int_to_float(node)
        "#{node.value.visit(self)}.to_f"
    end

    def visit_equals(node)
        "#{node.left.visit(self)} == #{node.right.visit(self)}"
    end

    def visit_not_equals(node)
        "#{node.left.visit(self)} != #{node.right.visit(self)}"
    end

    def visit_less_than(node)
        "#{node.left.visit(self)} < #{node.right.visit(self)}"
    end

    def visit_less_than_or_equal_to(node)
        "#{node.left.visit(self)} <= #{node.right.visit(self)}"
    end

    def visit_greater_than(node)
        "#{node.left.visit(self)} > #{node.right.visit(self)}"
    end

    def visit_greater_than_or_equal_to(node)
        "#{node.left.visit(self)} >= #{node.right.visit(self)}"
    end

    def visit_assign(node)
        "#{node.left.visit(self)} = #{node.right.visit(self)}"
    end
    
    def visit_rvalue(node)
        if node.is_a?(VarReference)
            "#{node.value}"
        else
            "#{node.value.visit(self).split[0]}"
        end
    end

    def visit_print(node)
        "print #{node.value.visit(self)}"
    end

    def visit_if(node)
        "if #{node.condition.visit(self)}\n#{node.block.map {|statement| statement.visit(self)}.join("\n")}\n#{node.elsee ? "else\n#{node.else_block.map {|statement| statement.visit(self)}.join("\n")}" : ""}"
    end

    def visit_while(node)
        "while #{node.condition.visit(self)}\n#{node.block.map {|statement| statement.visit(self)}.join("\n")}"
    end

    def visit_for_each(node)
        "for #{node.var.visit(self)} in [#{node.start.visit(self)}, #{node.endd.visit(self)}]\n#{node.block.map {|statement| statement.visit(self)}.join("\n")}"
    end

    def visit_function(node)
        "function #{node.name.visit(self)}(#{node.parameters.map {|parameter| parameter.visit(self)}.join(", ")})\n#{node.body.map {|statement| statement.visit(self)}.join("\n")}"
    end

    def visit_return(node)
        "return #{node.val.visit(self)}"
    end

    def visit_function_call(node)
        "#{node.name.visit(self)}(#{node.parameters.visit(self)})"
    end
end