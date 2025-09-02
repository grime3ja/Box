class Evaluator
    def visit_add(node)
        leftPrimitive = node.left.evaluate
        rightPrimitive = node.right.evaluate

        leftPrimitive.value + rightPrimitive.value
    end
end