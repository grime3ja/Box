require_relative 'primitive'

class Add
    def initialize(left, right)
        @left = left
        @right = right
    end

    def evaluate
        leftPrimitive = @left.evaluate
        rightPrimitive = @right.evaluate

        leftPrimitive.value + rightPrimitive.value
    end
end

class Subtraction
    def initialize(left, right)
        @left = left
        @right = right
    end

    def evaluate
        leftPrimitive = @left.evaluate
        rightPrimitive = @right.evaluate

        leftPrimitive.value - rightPrimitive.value
    end
end

class Multiply
    def initialize(left, right)
        @left = left
        @right = right
    end

    def evaluate
        leftPrimitive = @left.evaluate
        rightPrimitive = @right.evaluate

        leftPrimitive.value * rightPrimitive.value
    end
end

class Divide
    def initialize(left, right)
        @left = left
        @right = right
    end

    def evaluate
        leftPrimitive = @left.evaluate
        rightPrimitive = @right.evaluate

        leftPrimitive.value / rightPrimitive.value
    end
end

class Modulo
    def initialize(left, right)
        @left = left
        @right = right
    end

    def evaluate
        leftPrimitive = @left.evaluate
        rightPrimitive = @right.evaluate

        leftPrimitive.value % rightPrimitive.value
    end
end

class Exponent
    def initialize(left, right)
        @left = left
        @right = right
    end

    def evaluate
        leftPrimitive = @left.evaluate
        rightPrimitive = @right.evaluate

        leftPrimitive.value ** rightPrimitive.value
    end
end

class Negation
    def initialize(value)
        @value = value
    end

    def evaluate
        valuePrimitive = @value.evaluate

        !valuePrimitive
    end
end

# Video Demonstrations

m = Multiply.new(IntegerPrimitive.new(7), IntegerPrimitive.new(4))
p m.evaluate
a = Add.new(m, 3)
p a.evaluate

# arithmetic = Modulo.new(a, 12)
# p arithmetic.evaluate