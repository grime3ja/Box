require_relative 'primitive'
class Evaluator
    # attr_reader :runtime
    def initialize(runtime)
        @runtime = runtime
    end

    def visit_integer(node)
        node
    end

    def visit_float(node)
        node
    end

    def visit_boolean(node)
        node
    end

    def visit_string(node)
        node
    end

    def visit_null(node)
        node
    end

    def visit_var(node)
        node
    end

    def visit_add(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive, FloatPrimitive, or VarPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive) || (leftPrimitive.is_a? FloatPrimitive) || (leftPrimitive.is_a? VarPrimitive)
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive, FloatPrimitive, or VarPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive) || (rightPrimitive.is_a? FloatPrimitive) || (rightPrimitive.is_a? VarPrimitive)

        sum = leftPrimitive.value + rightPrimitive.value
        if ((leftPrimitive.is_a? FloatPrimitive) || (rightPrimitive.is_a? FloatPrimitive))
            FloatPrimitive.new(sum)
        else
            IntegerPrimitive.new(sum)
        end
    end

    def visit_subtract(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive, FloatPrimitive, or VarPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive) || (leftPrimitive.is_a? FloatPrimitive) || (leftPrimitive.is_a? VarPrimitive)
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive, FloatPrimitive, or VarPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive) || (rightPrimitive.is_a? FloatPrimitive) || (rightPrimitive.is_a? VarPrimitive)

        sub = leftPrimitive.value - rightPrimitive.value
        if ((leftPrimitive.is_a? FloatPrimitive) || (rightPrimitive.is_a? FloatPrimitive))
            FloatPrimitive.new(sub)
        else
            IntegerPrimitive.new(sub)
        end
    end

    def visit_multiply(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive, FloatPrimitive, or VarPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive) || (leftPrimitive.is_a? FloatPrimitive) || (leftPrimitive.is_a? VarPrimitive)
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive, FloatPrimitive, or VarPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive) || (rightPrimitive.is_a? FloatPrimitive) || (rightPrimitive.is_a? VarPrimitive)

        product = leftPrimitive.value * rightPrimitive.value
        if ((leftPrimitive.is_a? FloatPrimitive) || (rightPrimitive.is_a? FloatPrimitive))
            FloatPrimitive.new(product)
        else
            IntegerPrimitive.new(product)
        end
    end

    def visit_divide(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive, FloatPrimitive, or VarPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive) || (leftPrimitive.is_a? FloatPrimitive) || (leftPrimitive.is_a? VarPrimitive)
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive, FloatPrimitive, or VarPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive) || (rightPrimitive.is_a? FloatPrimitive) || (rightPrimitive.is_a? VarPrimitive)

        quo = leftPrimitive.value / rightPrimitive.value
        if ((leftPrimitive.is_a? FloatPrimitive) || (rightPrimitive.is_a? FloatPrimitive))
            FloatPrimitive.new(quo)
        else
            IntegerPrimitive.new(quo)
        end
    end

    def visit_modulo(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive, FloatPrimitive, or VarPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive) || (leftPrimitive.is_a? FloatPrimitive) || (leftPrimitive.is_a? VarPrimitive)
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive, FloatPrimitive, or VarPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive) || (rightPrimitive.is_a? FloatPrimitive) || (rightPrimitive.is_a? VarPrimitive)

        mod = leftPrimitive.value % rightPrimitive.value
        if ((leftPrimitive.is_a? FloatPrimitive) || (rightPrimitive.is_a? FloatPrimitive))
            FloatPrimitive.new(mod)
        else
            IntegerPrimitive.new(mod)
        end
    end

    def visit_exponent(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive, FloatPrimitive, or VarPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive) || (leftPrimitive.is_a? FloatPrimitive) || (leftPrimitive.is_a? VarPrimitive)
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive, FloatPrimitive, or VarPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive) || (rightPrimitive.is_a? FloatPrimitive) || (rightPrimitive.is_a? VarPrimitive)

        exp = leftPrimitive.value ** rightPrimitive.value
        if ((leftPrimitive.is_a? FloatPrimitive) || (rightPrimitive.is_a? FloatPrimitive))
            FloatPrimitive.new(exp)
        else
            IntegerPrimitive.new(exp)
        end
    end

    
    def visit_negate(node)
        val = node.value.visit(self)
        raise "Expected #{val} to be type IntegerPrimitive, FloatPrimitive, or VarPrimitive" unless (val.is_a? IntegerPrimitive) || (val.is_a? FloatPrimitive) || (val.is_a? VarPrimitive)

        negate = -val.value
        if ((val.is_a? FloatPrimitive))
            FloatPrimitive.new(negate)
        end
        IntegerPrimitive.new(negate)
    end

    def visit_and(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type BooleanPrimitive" unless (leftPrimitive.is_a? BooleanPrimitive)
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type BooleanPrimitive" unless (rightPrimitive.is_a? BooleanPrimitive)

        a = leftPrimitive.value && rightPrimitive.value
        BooleanPrimitive.new(a)
    end

    def visit_or(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type BooleanPrimitive" unless (leftPrimitive.is_a? BooleanPrimitive)
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type BooleanPrimitive" unless (rightPrimitive.is_a? BooleanPrimitive)

        o = leftPrimitive.value || rightPrimitive.value
        BooleanPrimitive.new(o)
    end

    def visit_not(node)
        value = node.value.visit(self)
        raise "Expected #{value} to be type BooleanPrimitive" unless (value.is_a? BooleanPrimitive)

        n = !value.value
        BooleanPrimitive.new(n)
    end
    def visit_bit_and(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive)
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive)

        bit_and = leftPrimitive.value & rightPrimitive.value
        IntegerPrimitive.new(bit_and)
    end

    def visit_bit_or(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive)
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive)

        bit_or = leftPrimitive.value | rightPrimitive.value
        IntegerPrimitive.new(bit_or)
    end

    def visit_bit_xor(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive)

        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive)

        bit_xor = leftPrimitive.value ^ rightPrimitive.value
        IntegerPrimitive.new(bit_xor)
    end

    def visit_bit_not(node)
        value = node.value.visit(self)
        raise "Expected #{value} to be type IntegerPrimitive" unless (value.is_a? IntegerPrimitive)
        
        bit_not = ~value.value
        IntegerPrimitive.new(bit_not)
    end

    def visit_bit_left(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive)
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive)

        product = leftPrimitive.value << rightPrimitive.value
        IntegerPrimitive.new(product)
    end

    def visit_bit_right(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive)
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive)

        bit_right = leftPrimitive.value >> rightPrimitive.value
        IntegerPrimitive.new(bit_right)
    end
    def visit_float_to_int(node)
        value = node.value.visit(self)
        raise "Expected #{value} to be type FloatPrimitive" unless (value.is_a? FloatPrimitive)
        f_to_i = value.value.to_i
        IntegerPrimitive.new(f_to_i)
    end

    def visit_int_to_float(node)
        value = node.value.visit(self)
        raise "Expected #{value} to be type Integer Primitive" unless (value.is_a? IntegerPrimitive)
        i_to_f = value.value.to_f
        FloatPrimitive.new(i_to_f)
    end

    def visit_assign(node)
        leftPrimitive = node.left.visit(self)
        rightPrimitive = node.right.visit(self)
        raise "Expected #{leftPrimitive} to be type Variable Primitive" unless (leftPrimitive.is_a? VarPrimitive)
        @runtime.set(leftPrimitive.value, rightPrimitive)
    end

    def visit_rvalue(node)
        if node.value.is_a?(Assignment)
          return node.value.visit(self)
        end
        variable = node.value
        value = @runtime.get(variable)
        case value
        when FloatPrimitive
            FloatPrimitive.new(value.value)
        when StringPrimitive
            StringPrimitivePrimitive.new(value)
        when BooleanPrimitive
            BooleanPrimitive.new(value)
        when IntegerPrimitive
            IntegerPrimitive.new(value.value)
        when NullPrimitive
            NullPrimitive.new(value)
        else
            raise "Variable reference to #{variable.inspect} yielded no results"
        end
    end
    
    def visit_print(node)
        p node.value.visit(self)
        NullPrimitive.new
    end

    def visit_equals(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive, FloatPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive) || (leftPrimitive.is_a? FloatPrimitive)        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive, FloatPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive) || (rightPrimitive.is_a? FloatPrimitive)        

        eq = leftPrimitive.value == rightPrimitive.value
        BooleanPrimitive.new(eq)
    end

    def visit_not_equals(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive, FloatPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive) || (leftPrimitive.is_a? FloatPrimitive)        
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive, FloatPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive) || (rightPrimitive.is_a? FloatPrimitive)        

        ne = leftPrimitive.value != rightPrimitive.value
        BooleanPrimitive.new(ne)
    end

    def visit_less_than(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive, FloatPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive) || (leftPrimitive.is_a? FloatPrimitive)        
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive, FloatPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive) || (rightPrimitive.is_a? FloatPrimitive)        

        lt = leftPrimitive.value < rightPrimitive.value
        BooleanPrimitive.new(lt)
    end

    def visit_less_than_or_equal_to(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive, FloatPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive) || (leftPrimitive.is_a? FloatPrimitive)        
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive, FloatPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive) || (rightPrimitive.is_a? FloatPrimitive)        

        le = leftPrimitive.value <= rightPrimitive.value
        BooleanPrimitive.new(le)
    end

    def visit_greater_than(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive, FloatPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive) || (leftPrimitive.is_a? FloatPrimitive)        
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive, FloatPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive) || (rightPrimitive.is_a? FloatPrimitive)        

        gt = leftPrimitive.value > rightPrimitive.value
        BooleanPrimitive.new(gt)
    end

    def visit_greater_than_or_equal_to(node)
        leftPrimitive = node.left.visit(self)
        raise "Expected #{leftPrimitive} to be type IntegerPrimitive, FloatPrimitive" unless (leftPrimitive.is_a? IntegerPrimitive) || (leftPrimitive.is_a? FloatPrimitive)        
        
        rightPrimitive = node.right.visit(self)
        raise "Expected #{rightPrimitive} to be type IntegerPrimitive, FloatPrimitive" unless (rightPrimitive.is_a? IntegerPrimitive) || (rightPrimitive.is_a? FloatPrimitive)        

        ge = leftPrimitive.value >= rightPrimitive.value
        BooleanPrimitive.new(ge)
    end

    def visit_if(node)
        if(node.condition.visit(self).value)
            node.block[..-1].each do |line|
                line.visit(self)
            end
            node.block[-1].value.eql?("end") ? node.block[-2] : node.block[-1]
        elsif(node.elsee.visit(self).value)
            node.else_block[..-1].each do |line|
                line.visit(self)
            end
            node.else_block[-1].value.eql?("end") ? node.else_block[-2] : node.else_block[-1]
        else
            NullPrimitive.new
        end
    end

    def visit_while(node)
        if(node.condition.visit(self).value)
            node.block[..-1].each do |line|
                line.visit(self)
            end
            node.visit(self)
        else
            NullPrimitive.new
        end
    end

    def visit_for_each(node)
        raise "Expected #{node.var} to be type VarPrimitive or VarReference" unless (node.var.is_a? VarPrimitive) || (node.var.is_a? VarReference)
        @runtime.set(node.var.value, node.start.visit(self))
        (node.start.visit(self).value + 1..node.endd.visit(self).value).each do |i|
            node.block[..-1].each do |line|
                line.visit(self)
            end
            @runtime.set(node.var.value, IntegerPrimitive.new(i))
        end
        @runtime.get(node.var.value)
    end

    def visit_function(node)
        @runtime.add_func(node.name.value, node)
        node
    end

    # def visit_return(node)
    #     raise NameError.new("#{@runtime.get(node.val.value).inspect}")
    # end

    def visit_function_call(node)
        raise "Function call to \"#{node.name.value}\" yielded no results" if !@runtime.has_func(node.name.value)
        function = @runtime.get_func(node.name.value)
        function_runtime = Runtime.new
        i = 0
        function.parameters.each do |var|
            function_runtime.set(var.value, node.parameters[i].visit(self))
            i += 1
        end
        temp_runtime = @runtime
        @runtime = function_runtime
        p @runtime

        returned = NullPrimitive.new
        function.body.each do |line|
            begin
                line.visit(self)
            rescue ReturnException => e
                @runtime = temp_runtime
                returned = e.value
            end
        end
        returned
    end
    class ReturnException < StandardError
        attr_reader :value

        def initialize(value)
            @value = value
        end
    end
    def visit_return(node)
        value = node.val.visit(self)
        raise ReturnException.new(value)
    end

end


class Runtime
    attr_reader :vars, :funcs
    def initialize
        @vars = {}
        @funcs = {}
    end

    def get(name)
        @vars[name]
    end

    def set(name,value)
        @vars[name] = value
    end

    def add_func(name, node)
        @funcs[name] = node
    end

    def get_func(name)
        @funcs[name]
    end

    def has_func(name)
        @funcs.has_key?(name)
    end
end
