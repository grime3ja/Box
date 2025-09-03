class FloatToInt
    attr_reader :value
    def initialize(value)
        @value = value
    end
    def visit(visitor)
        visitor.visit_float_to_int(self)
    end
end

class IntToFloat
    attr_reader :value
    def initialize(value)
        @value = value
    end
    def visit(visitor)
        visitor.visit_int_to_float(self)
    end
end