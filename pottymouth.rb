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
table = Window.new(height / 4, width / 2, height / 4, w)

table.setpos(1, 3.5)
table.addstr(" a ")
table.setpos(2, 0)
table.addstr("_________")
a_column = table.derwin(height / 4, width / 15, 0, 0)
a_column.setpos(1, width / 10)
a_column.box('|', '-')
a_column.refresh
table.setpos(1, width / 12)
table.addstr(" b ")
table.setpos(2, 10)
table.addstr("________")
table.refresh
b_column = table.derwin(height / 4, width / 15, 0, w / 2)
b_column.setpos(1, width / 11)
b_column.box('|', '-')
b_column.refresh
act_column = table.derwin(height / 4, 34, 0, w / 2)
act_column.setpos(1, width / 3)
act_column.box('|', '-')
act_column.refresh
table.setpos(1, 21)
table.addstr(" c ")
table.setpos(2, 19)
table.addstr("________")
table.setpos(1, 35)
table.addstr(" actual ")
table.setpos(2, 28)
table.addstr("_______________________")
table.setpos(1, 60)
table.addstr(" expected ")
table.setpos(2, 52)
table.addstr("________________________")


table.box('|', '-')
table.refresh
output = Window.new(height / 4, width / 2, height / 2, w)
output.setpos(1, width / 4.25)
output.addstr("Output")
output.box('|', '-')
output.refresh
y = 4

loop do
  function.setpos(0, 0)
  c = function.getch
  lex_string = []
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
          j = [4, 13, 22]
          current = 0
          lex_string.each do |value|
            var_lex = Lexer.new(value)
            var_tokens = var_lex.lex_string
            var_parse = Parser.new(var_tokens)
            var_parsed = var_parse.parse
            var_parsed.visit(Evaluator.new(runtime))
            table.setpos(y,j[current])
            table.addstr(var_tokens[-1].text)
            current += 1
            # j += 8
          end
          y += 1
          table.refresh
          expr_lex = Lexer.new(expr)
          expr_tokens = expr_lex.lex_string
          expr_parse = Parser.new(expr_tokens).parse
          output.setpos(3,3)
          begin
            expr_eval = expr_parse.visit(Evaluator.new(runtime))
            expr_translate = expr_eval.visit(Translator.new()).to_s
          rescue StandardError => e
            output.addstr(e.message)
          end
          output.addstr(expr_translate)
          output.refresh
          break
        elsif i == ' '
          inputs.setpos(3,x)
          inputs.addstr(i)
          x += 1
          lex_string << "#{letter.chr} = #{param_string} "
          # output.addstr(lex_string.to_s)
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