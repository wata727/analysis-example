class Equal
  def initialize(lhs, rhs)
    @lhs = lhs
    @rhs = rhs
  end

  def call(state)
    @lhs.call(state) == @rhs.call(state)
  end
end
