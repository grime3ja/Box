require_relative 'primitive'
require_relative 'evaluator'

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
