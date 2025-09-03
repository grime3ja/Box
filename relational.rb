class Equals
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def visit(visitor)
      visitor.visit_equals(self)
    end
end

class NotEquals
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def visit(visitor)
      visitor.visit_not_equals(self)
    end
end

class LessThan
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def visit(visitor)
      visitor.visit_less_than(self)
    end
end

class LessThanOrEqualTo
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def visit(visitor)
      visitor.visit_less_than_or_equal_to(self)
    end
end

class GreaterThan
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def visit(visitor)
      visitor.visit_greater_than(self)
    end
end

class GreaterThanOrEqualTo
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def visit(visitor)
      visitor.visit_greater_than_or_equal_to(self)
    end
end