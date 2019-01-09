class Composition
  def initialize(f1, f2)
    @f1 = f1
    @f2 = f2
  end

  def call(state)
    @f2.call(@f1.call(state))
  end
end
