require_relative 'translator'

class IntegerPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        return visitor.visit_integer(self)
    end
end

class FloatPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        return visitor.visit_float(self)
    end
end

class BooleanPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        return visitor.visit_boolean(self)
    end
end

class StringPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        return visitor.visit_string(self)
    end
end

class NullPrimitive
    attr_reader :value
    def initialize
        @value = nil
    end

    def visit(visitor)
        return visitor.visit_null(self)
    end
end
