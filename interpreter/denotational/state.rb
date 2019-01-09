class State
  def update(name, val)
    instance_variable_set("@#{name}".to_sym, val)
    self
  end

  def fetch(name)
    instance_variable_get("@#{name}")
  end
end
