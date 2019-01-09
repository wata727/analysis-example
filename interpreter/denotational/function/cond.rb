class Cond
  def initialize(cond, s1, s2)
    @cond = cond
    @s1 = s1
    @s2 = s2
  end

  def call(state)
    if @cond.call(state)
      @s1.call(state)
    else
      @s2.call(state)
    end
  end
end
