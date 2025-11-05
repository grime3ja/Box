require 'curses' # thus pottymouth
require_relative 'lexer'
require_relative 'parser'
require_relative 'translator'
require_relative 'evaluator'
include Curses

init_screen
noecho
curs_set(0)

width = Curses.cols
height = Curses.lines
runtime = Runtime.new
eval = Evaluator.new(runtime)
w = width / 2.75
function = Window.new(height / 8, width / 4, 0, w)
i = 1
function.setpos(i, width / 12)
lines = File.readlines(ARGV[0]).map(&:chomp)
expr = lines[1]
p expr
File.foreach(ARGV[0]) do |line|
  function.setpos(i, width / 12)
  i += 1
  function.addstr(line)
end

function.box('|', '-')
function.refresh

inputs = Window.new(height / 8, width / 4, height / 8, w)
i = 1
inputs.setpos(i, width / 16)
inputs.addstr("input parameters here")

inputs.box('|', '-')
inputs.refresh

w = width / 4.25
actual = Window.new(height / 4, width / 2, height / 4, w)

actual.setpos(1, width / 30)
actual.addstr("a: ")
actual.setpos(1, width / 10)
actual.addstr("b: ")
actual.setpos(1, width / 6)
actual.addstr("c: ")
actual.setpos(1, width / 3)
actual.addstr("actual: ")
actual.setpos(1, width / 2)
actual.addstr("expected: ")

actual.box('|', '-')
actual.refresh
output = Window.new(height / 4, width / 2, height / 2, w)
output.setpos(1, width / 4.25)
output.addstr("Output")
output.box('|', '-')
output.refresh

loop do
  function.setpos(0, 0)
  c = function.getch
  lex_string = ""
  if c == 'q'
    break
  elsif c == 'i'
      x = 2
      param_string = ""
      letter = 97
      loop do
        i = inputs.getch
        if i == 10
          lex_string << "#{letter.chr} = #{param_string}"
          inputs.setpos(4,3)
          var_lex = Lexer.new(lex_string)
          var_tokens = var_lex.lex_string
          var_parse = Parser.new(var_tokens)
          var_parsed = var_parse.parse
          var_parsed.visit(Evaluator.new(runtime))
          expr_lex = Lexer.new(expr)
          expr_tokens = expr_lex.lex_string
          expr_parse = Parser.new(expr_tokens).parse
          expr_eval = expr_parse.visit(Evaluator.new(runtime))
          expr_translate = expr_eval.visit(Translator.new()).to_s
          output.setpos(3,3)
          output.addstr(expr_translate)
          output.refresh
          break
        elsif i == ' '
          inputs.setpos(3,x)
          inputs.addstr(i)
          x += 1
          lex_string << "#{letter.chr} = #{param_string} "
          letter += 1
          param_string = ""
        else
          inputs.setpos(3,x)
          inputs.addstr(i)
          x += 1
          param_string << i.chr
        end
      end 
  else
    # input_panel.clear
    # input_panel.addstr(c.ord.to_s)
  end
end

function.close
close_screen