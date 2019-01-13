class Not
  def initialize(expr)
    @expr = expr
  end

  def call(state)
    !@expr.call(state)
  end
end
