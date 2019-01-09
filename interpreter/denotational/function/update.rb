class Update
  def initialize(name, val)
    @name = name
    @val = val
  end

  def call(state)
    state.update(@name.call(state), @val.call(state))
  end
end
