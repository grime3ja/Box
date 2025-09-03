class BitAnd
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end
    def visit(visitor)
        visitor.visit_bit_and(self)
    end
    
end

class BitOr
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end
    def visit(visitor)
        visitor.visit_bit_or(self)
    end
end

class BitXor
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end
    def visit(visitor)
        visitor.visit_bit_xor(self)
    end
end

class BitNot
    attr_reader :value
    def initialize(value)
        @value = value
    end
    def visit(visitor)
        visitor.visit_bit_not(self)
    end
end

class BitLeft
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end
    def visit(visitor)
        visitor.visit_bit_left(self)
    end
end

class BitRight
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end
    def visit(visitor)
        visitor.visit_bit_right(self)
    end
end