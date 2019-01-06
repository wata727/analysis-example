require_relative "../parser/lib/parser.rb"
require_relative "../parser/lib/structure.rb"
require "stringio"
require "strscan"

@x = ARGV.first.to_i

# Operatiol semantic function 
def sos(node)
  case node
  when Integer, TrueClass, FalseClass
    node
  when AssignStmt
    instance_variable_set("@#{node.name}".to_sym, sos(node.val))
  when SkipStmt
    # noop
  when IfStmt
    # TODO
  when WhileStmt
    if sos(node.cond)
      node.stmt.each { |stmt| sos(stmt) }
      sos(node)
    end
  when NotExpr
    !sos(node.expr)
  when OrExpr
    sos(node.lhs) || sos(node.rhs)
  when EqualExpr
    sos(node.lhs) == sos(node.rhs)
  when LessEqualExpr
    sos(node.lhs) <= sos(node.rhs)
  when LIdentExpr
    instance_variable_get("@#{node.name}".to_sym)
  when PlusExpr
    sos(node.lhs) + sos(node.rhs)
  when MulExpr
    sos(node.lhs) * sos(node.rhs)
  when MinusExpr
    sos(node.lhs) - sos(node.rhs)
  end
end

ast = WhileParser.parse(File.read("example.wh"))

ast.each { |stmt| sos(stmt) }

instance_variables.each do |var|
  puts "#{var.to_s.delete("@")}: #{instance_variable_get(var.to_sym)}"
end
