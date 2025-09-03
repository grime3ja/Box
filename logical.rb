class And
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    def visit(visitor)
        visitor.visit_and(self)
    end
    end
end

class Or
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end
    def visit(visitor)
        visitor.visit_or(self)
    end
end

class Not
    attr_reader :value
    def initialize(value)
        @value = value
    end
    def visit(visitor)
        visitor.visit_not(self)
    end
end
