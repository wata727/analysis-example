require_relative "../parser/lib/parser.rb"
require_relative "../parser/lib/structure.rb"
require "stringio"
require "strscan"

@x = ARGV.first.to_i

# Denotational semantic function 
def sds(ast)
  case node
  when AssignStmt
    # TODO
  when SkipStmt
    # noop
  when IfStmt
    # TODO
  when WhileStmt
    fix
  end
end

def fixed_point(label)
  if label == 0
    nil
  else
    fixed_point(label -1)
  end
end

def fix(f, cond)
  if @x == 0
    Proc.new { |x, y| false } # undef
  else
    if cond(@x)
      @x = @x - 1
      f()
    else
      Proc.new { |x, y| y }
    end
  end
end

ast = WhileParser.parse(File.read("example.wh"))

func = Proc.new
ast.each do |stmt|
  func = func >> sds(stmt)
end
@y = func(@x)

instance_variables.each do |var|
  puts "#{var.to_s.delete("@")}: #{instance_variable_get(var.to_sym)}"
end
