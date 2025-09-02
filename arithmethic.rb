require_relative 'primitive'
require_relative 'evaluator'

class Add
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_add(self)
    end
end

class Subtraction
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_subtract(self)
    end
end

class Multiply
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_multiply(self)
    end
end

class Divide
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_divide(self)
    end
end

class Modulo
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_modulo(self)
    end
end

class Exponent
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_exponent(self)
    end
end

class Negation
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        visitor.visit_negate(self)
    end
end
