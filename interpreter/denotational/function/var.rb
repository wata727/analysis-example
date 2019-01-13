class Var
  def initialize(name)
    @name = name
  end

  def call(state)
    state.fetch(@name)
  end
end
