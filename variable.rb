class Assignment
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_assign(self)
    end
end
class PrintOut
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        visitor.visit_print(self)
    end
end
class VarReference
    attr_reader :value
    def initialize(value)
        @value = value
    end
    def visit(visitor)
        visitor.visit_rvalue(self)
    end
end