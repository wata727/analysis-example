require "parser"
require "structure"
require "stringio"
require "strscan"

require "minitest/autorun"

class HelloTest < Minitest::Test
  def test_1
    puts WhileParser.parse("2 + 1 - 1")
    puts WhileParser.parse("1 = 2 | not (2 <= 1)")
    puts WhileParser.parse("if true then skip else skip")
    puts WhileParser.parse("while true do skip")

    # Semantics with Applications An Appetizer (Nielson, Nielson)
    # Example 5.48, P.118
    puts WhileParser.parse("y := 1; while not (x=1) do (y:=y*x; x:=x-1)")
  end
end
