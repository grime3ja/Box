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
        @runtime.set(leftPrimitive, rightPrimitive)
    end

    def visit_rvalue(node)
        if node.value.class.eql?(Assignment)
          node.value.visit(self)
        end
        variable = node.value.left
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
end


class Runtime
    def initialize
        @vars = {}
    end

    def get(name)
        @vars[name]
    end

    def set(name,value)
        @vars[name] = value
    end
end