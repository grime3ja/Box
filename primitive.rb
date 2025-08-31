
class IntegerPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def evaluate
        return self
    end
end

class FloatPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def evaluate
        return self
    end
end

class BooleanPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def evaluate
        return self
    end
end

class StringPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def evaluate
        return self
    end
end

class NullPrimitive
    attr_reader :value
    def initialize
        @value = nil
    end

    def evaluate
        return self
    end
end

a = IntegerPrimitive.new(5)
# p a