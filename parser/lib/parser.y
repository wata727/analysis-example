class WhileParser

rule

  target: aexp | bexp | stmt

  aexp: INT                 { result = val[0] }
      | LIDENT              { result = LIdentExpr.new(val[0]) }
      | aexp PLUS aexp      { result = PlusExpr.new(val[0], val[2]) }
      | aexp MUL aexp       { result = MulExpr.new(val[0], val[2]) }
      | aexp MINUS aexp     { result = MinusExpr.new(val[0], val[2]) }
      | LPAREN aexp RPAREN  { result = val[1] }

  bexp: BOOL                { result = val[0] }
      | aexp EQ aexp        { result = EqualExpr.new(val[0], val[2]) }
      | aexp LEQ aexp       { result = LessEqualExpr.new(val[0], val[2]) }
      | NOT bexp            { result = NotExpr.new(val[1]) }
      | bexp OR bexp        { result = OrExpr.new(val[0], val[2]) }
      | LPAREN bexp RPAREN  { result = val[1] }

  stmt: LIDENT ASSIGN aexp          { result = [AssignStmt.new(val[0], val[2])] }
      | SKIP                        { result = [SkipStmt.new(true)] }
      | stmt END stmt               { result = val[0] + val[2] }
      | IF bexp THEN stmt ELSE stmt { result = [IfStmt.new(val[1], val[3], val[5])] }
      | WHILE bexp DO stmt          { result = [WhileStmt.new(val[1], val[3])] }
      | LPAREN stmt RPAREN          { result = val[1] }

---- inner

attr_reader :input

def initialize(input)
  @input = StringScanner.new(input)
end

def self.parse(string)
  self.new(string).do_parse
end

def next_token
  case
  when input.eos?
    [false, false]
  when input.scan(/\s+/)
    next_token
  when input.scan(/\(/)
    [:LPAREN, nil]
  when input.scan(/\)/)
    [:RPAREN, nil]
  when input.scan(/\+/)
    [:PLUS, nil]
  when input.scan(/\*/)
    [:MUL, nil]
  when input.scan(/\-/)
    [:MINUS, nil]
  when input.scan(/=/)
    [:EQ, nil]
  when input.scan(/<=/)
    [:LEQ, nil]
  when input.scan(/\|/)
    [:OR, nil]
  when input.scan(/:=/)
    [:ASSIGN, nil]
  when input.scan(/;/)
    [:END, nil]
  when input.scan(/not\b/)
    [:NOT, nil]
  when input.scan(/true\b/)
    [:BOOL, true]
  when input.scan(/false\b/)
    [:BOOL, false]
  when input.scan(/skip\b/)
    [:SKIP, nil]
  when input.scan(/if\b/)
    [:IF, nil]
  when input.scan(/then\b/)
    [:THEN, nil]
  when input.scan(/else\b/)
    [:ELSE, nil]
  when input.scan(/while\b/)
    [:WHILE, nil]
  when input.scan(/do\b/)
    [:DO, nil]
  when input.scan(/\d+/)
    [:INT, input.matched.to_i]
  when input.scan(/[a-z]/)
    [:LIDENT, input.matched.to_sym]
  end
end
