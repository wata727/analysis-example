require_relative "../../parser/lib/parser"
require_relative "../../parser/lib/structure"
require "stringio"
require "strscan"

require_relative "state"

x = ARGV.first.to_i

def math_object(node)
  case node
  when Array
    Composition
  when Integer
    Number
  when TrueClass, FalseClass
    Bool
  when AssignStmt
    Update
  when SkipStmt
    Identity
  when IfStmt
    Cond
  when WhileStmt
    Fix
  when NotExpr
    Not
  when OrExpr
    OR
  when EqualExpr
    Equal
  when LessEqualExpr
    LessEqual
  when LIdentExpr
    Var
  when PlusExpr
    Plus
  when MulExpr
    Mul
  when MinusExpr
    Minus
  end
end

ast = WhileParser.parse(File.read("../example.wh"))
state = State.new(x)

f = math_object(ast)
s = f.call(s)

s.instance_variables.each do |var|
  puts "#{var.to_s.delete("@")}: #{s.instance_variable_get(var.to_sym)}"
end
