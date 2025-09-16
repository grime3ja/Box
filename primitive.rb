
class IntegerPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        visitor.visit_integer(self)
    end
end

class FloatPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        visitor.visit_float(self)
    end
end

class BooleanPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end


    def visit(visitor)
        visitor.visit_boolean(self)
    end
end

class StringPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end
    def visit(visitor)
        visitor.visit_string(self)
    end
end

class NullPrimitive
    attr_reader :value
    def initialize
        @value = nil
    end
end
class VarPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end
    def assign_value(new_value)
        @value = new_value
    end
    def visit(visitor)
        visitor.visit_var(self)
    end
end

# p a