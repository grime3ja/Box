class If
  attr_reader :condition, :block, :elsee, :else_block
  def initialize(condition, block, elsee, else_block)
    @condition = condition
    @block = block
    @elsee = elsee
    @else_block = else_block
  end

  def visit(visitor)
    visitor.visit_if(self)
  end
end

class While
  attr_reader :condition, :block
  def initialize(condition, block)
    @condition = condition
    @block = block
  end

  def visit(visitor)
    visitor.visit_while(self)
  end
end

class ForEach
  attr_reader :var, :start, :endd, :block
  def initialize(var, start, endd, block)
    @var = var
    @start = start
    @endd = endd
    @block = block
  end

  def visit(visitor)
    visitor.visit_for_each(self)
  end
end

class Function
  attr_reader :name, :parameters, :body
  def initialize(name, parameters, body)
    @name = name
    @parameters = parameters
    @body = body
  end

  def visit(visitor)
    visitor.visit_function(self)
  end
end

class Return
  attr_reader :val
  def initialize(val)
    @val = val
  end

  def visit(visitor)
    visitor.visit_return(self)
  end
end

class FunctionCall
  attr_reader :name, :parameters
  def initialize(name, parameters)
    @name = name
    @parameters = parameters
  end

  def visit(visitor)
    visitor.visit_function_call(self)
  end
end