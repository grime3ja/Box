require 'curses' # thus pottymouth
require_relative 'lexer'
require_relative 'parser'
require_relative 'translator'
require_relative 'evaluator'
include Curses

module Modes
  FUNCTION = 0
  INPUT = 1
  WAITING = 2
end

def display_help_messages(mode)
  case mode
    when Modes::FUNCTION
      "<FUNCTION>:\n1. Write your guess for what the mystery function is (hint make sure you use a, b, and c for parameters)\n2. Press enter to enter <INPUT> mode"
    when Modes::INPUT
      "<INPUT>:\n1. Write your parameter list\n2. Press enter to run your function against our mystery function"
    when Modes::WAITING
      "Press 'f' for <FUNCTION> mode, 'i' for <INPUT> mode, otherwise 'q' to exit Pottymouth"
    else
      "Invalid mode. Press 'f' for <FUNCTION> mode, otherwise 'q' to exit Pottymouth"
  end
end
init_screen
noecho
curs_set(0)

width = Curses.cols
height = Curses.lines
w = width / 2.75
function = Window.new(height / 8, width / 4, 0, w)
i = 1
function.setpos(i, width / 20)
lines = File.readlines(ARGV[0]).map(&:chomp)
exp_type = lines[0]
exp_expr = lines[1]

function.addstr("Enter your function guess here")
function.box('|', '-')
function.refresh

inputs = Window.new(height / 8, width / 4, height / 8, w)
i = 1
inputs.setpos(i, width / 30)
inputs.addstr("Input Parameters, expecting: #{exp_type}")

inputs.box('|', '-')
inputs.refresh

w = width / 4.25
table = Window.new(height / 4, width / 2, height / 4, w)

table.setpos(1, width / 35)
table.addstr(" a ")
table.setpos(2, width / 130)
table.addstr("_________")
a_column = table.derwin(height / 4, width / 15, 0, 0)
a_column.setpos(1, width / 10)
a_column.box('|', '-')
a_column.refresh
table.setpos(1, width / 12)
table.addstr(" b ")
table.setpos(2, 12)
table.addstr("__________")
table.refresh
b_column = table.derwin(height / 4, width / 15, 0, w / 2)
b_column.setpos(1, width / 11)
b_column.box('|', '-')
b_column.refresh
act_column = table.derwin(height / 4, 34, 0, w / 2)
act_column.setpos(1, width / 3)
act_column.box('|', '-')
act_column.refresh
table.setpos(1, 26)
table.addstr(" c ")
table.setpos(2, 23)
table.addstr("__________")
table.setpos(1, 40)
table.addstr(" actual ")
table.setpos(2, 34)
table.addstr("_____________________")
table.setpos(1, 60)
table.addstr(" expected ")
table.setpos(2, 56)
table.addstr("________________________")


table.box('|', '-')
table.refresh
output = Window.new(height / 4, width / 2, height / 2, w)
display = Window.new(4, width - 5, height - 5, 5)
y_position = 4
def param_eval(inputs, lex_string, table, act_expr,exp_expr,output, y)
  actual_runtime = Runtime.new
  expected_runtime = Runtime.new
  x = 2
  param_string = ""
  letter = 97
  loop do
    i = inputs.getch
    if i == 10
      # mode = Modes::WAITING
      lex_string << "#{letter.chr} = #{param_string}"
      inputs.setpos(4,3)
      j = [4, 13, 22]
      current = 0
      exp_translate = ""
      actual_translate = ""
      begin
        lex_string.each do |value|
          var_lex = Lexer.new(value)
          var_tokens = var_lex.lex_string
          var_parse = Parser.new(var_tokens)
          var_parsed = var_parse.parse
          var_parsed.visit(Evaluator.new(actual_runtime))
          var_parsed.visit(Evaluator.new(expected_runtime))
          table.setpos(y,j[current])
          table.addstr(var_tokens[-1].text)
          current += 1
        end
        exp_lex = Lexer.new(exp_expr)
        exp_tokens = exp_lex.lex_string
        exp_parse = Parser.new(exp_tokens).parse
        act_lex = Lexer.new(act_expr)
        act_tokens = act_lex.lex_string
        act_parse = Parser.new(act_tokens).parse
        table.setpos(y,60)
        exp_eval = exp_parse.visit(Evaluator.new(expected_runtime))
        exp_translate = exp_eval.visit(Translator.new).to_s
        actual_eval = act_parse.visit(Evaluator.new(actual_runtime))
        actual_translate = actual_eval.visit(Translator.new).to_s
        table.addstr(exp_translate)
        table.setpos(y, 40)
        table.addstr(actual_translate)
        if actual_translate == exp_translate
          output.clear
          output.setpos(2, 3)
          output.addstr("Your function is correct!")
          output.refresh
        else
          output.clear
          output.setpos(2, 3)
          output.addstr("#{act_expr} is not the correct function.")
          output.refresh
        end
        table.refresh
        output.refresh
      rescue StandardError => e
        output.clear
        output.setpos(2, 3)
        output.addstr(e.message)
        output.refresh
      end
      y += 1
      table.refresh
      param_string = ""
      letter = 97
      lex_string.clear
      inputs.clear
      lines = File.readlines(ARGV[0]).map(&:chomp)
      exp_type = lines[0]
      inputs.setpos(1, (Curses.cols) / 30)
      inputs.addstr("Input Parameters, expecting: #{exp_type}")
      inputs.box('|', '-')
      inputs.refresh
      x = 2
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
  return y
end
mode = Modes::WAITING
act_expr = ""
loop do
  output.setpos(1, (Curses.cols) / 4.25)
  output.addstr("Output")
  output.box('|', '-')
  output.refresh
  
  display.setpos(1, 1)
  display.clear
  display.addstr(display_help_messages(mode))
  display.refresh

  function.setpos(0, 0)
  c = function.getch
  lex_string = []
  if c == 'q'
    break
  elsif c == 'f'
    act_expr = ""
    function.clear
    function.setpos(1, (Curses.cols) / 20)
    function.addstr("Enter your function guess here")
    function.box('|', '-')
    function.refresh
    mode = Modes::FUNCTION
    display.clear
    display.addstr(display_help_messages(mode))
    display.refresh
      loop do
        chr = function.getch
        if chr == 10
          act_expr = act_expr.strip
          function.setpos(3, 2)
          function.addstr("Guess has been entered: #{act_expr}")
          function.refresh 
          mode = Modes::INPUT
          display.clear
          display.addstr(display_help_messages(mode))
          display.refresh
          break
        else
          act_expr << chr
          function.setpos(2, 2)
          function.addstr(act_expr)
          function.refresh
        end
      end
      y_position = param_eval(inputs, lex_string, table, act_expr,exp_expr,output, y_position)
      mode = Modes::WAITING
      
  elsif c == 'i'
    mode = Modes::INPUT
    display.clear
    display.addstr(display_help_messages(mode))
    display.refresh
    y_position = param_eval(inputs, lex_string, table, act_expr,exp_expr,output, y_position)
    mode = Modes::WAITING
     
  else
    # input_panel.clear
    # input_panel.addstr(c.ord.to_s)
  end
end

function.close
close_screen