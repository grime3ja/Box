class And
    def initialize(left, right)
        @left = left
        @right = right
    end

    def evaluate
        leftPrimitive = @left.evaluate
        rightPrimitive = @right.evaluate

        leftPrimitive && rightPrimitive
    end
end

class Or
    def initialize(left, right)
        @left = left
        @right = right
    end

    def evaluate
        leftPrimitive = @left.evaluate
        rightPrimitive = @right.evaluate

        leftPrimitive || rightPrimitive
    end
end

class Not
    def initialize(value)
        @value = value
    end

    def evaluate
        valuePrimitive = @value.evaluate

        !valuePrimitive
    end
end
