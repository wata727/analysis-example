require_relative "../../parser/lib/parser"
require_relative "../../parser/lib/structure"
require "stringio"
require "strscan"

require_relative "state"

x = ARGV.first.to_i

def function(node)
  case node
  when Array
    Composition.new(function(node[0]), function(node[1]))
  when Integer
    Number.new(node)
  when TrueClass, FalseClass
    Bool.new(node)
  when AssignStmt
    Update.new(function(node.name), function(node.val))
  when SkipStmt
    Identity.new
  when IfStmt
    Cond.new(function(node.cond), function(node.true), function(node.false))
  when WhileStmt
    Fix.new(function(node.cond), function(node.stmt))
  when NotExpr
    Not.new(function(node.expr))
  when OrExpr
    Or.new(function(node.lhs), function(node.rhs))
  when EqualExpr
    Equal.new(function(node.lhs), function(node.rhs))
  when LessEqualExpr
    LessEqual.new(function(node.lhs), function(node.rhs))
  when LIdentExpr
    Var.new(node.name)
  when PlusExpr
    Plus.new(function(node.lhs), function(node.rhs))
  when MulExpr
    Mul.new(function(node.lhs), function(node.rhs))
  when MinusExpr
    Minus.new(function(node.lhs), function(node.rhs))
  end
end

ast = WhileParser.parse(File.read("../example.wh"))
state = State.new.update(x, @x)

f = function(ast)
s = f.call(s)

s.instance_variables.each do |var|
  puts "#{var.to_s.delete("@")}: #{s.instance_variable_get(var.to_sym)}"
end
