require 'curses' # thus pottymouth
require_relative 'lexer'
require_relative 'parser'
require_relative 'translator'
require_relative 'evaluator'
include Curses

# helper message modes so users aren't lost with button clicking
# we took a vim/nano route, which will be shown in the demo
module Modes
  FUNCTION = 0
  INPUT = 1
  WAITING = 2
  INVALID = 3
end

def display_help_messages(mode)
  case mode
    when Modes::FUNCTION
      "<FUNCTION>:\n1. Write your guess for what the mystery function is (hint make sure you use a, b, and c for parameters)\n2. Press CTRL-C/Command to enter <INPUT> mode"
    when Modes::INPUT
      "<INPUT>:\n1. Write your parameter list\n2. Press enter to run your function against our mystery function"
    when Modes::WAITING
      "Press 'f' for <FUNCTION> mode, 'i' for <INPUT> mode, otherwise 'q' to exit Pottymouth"
    else
      "Invalid mode. Press 'f' for <FUNCTION> mode, 'i' for <INPUT> mode, otherwise 'q' to exit Pottymouth"
  end
end
# main screen
init_screen
noecho
curs_set(0)

width = Curses.cols
height = Curses.lines
w = width / 2.75

# user input function window
function = Window.new(height / 1.25, width / 4.5, 0, 1)
i = 1
function.setpos(i, width / 30)
lines = File.readlines(ARGV[0]).map(&:chomp)
exp_type = lines[0]
exp_expr = lines[1..]

function.addstr("Enter your function guess here")
function.box('|', '-')
function.refresh

# user input parameter window
w = width / 3.15
inputs = Window.new(height / 8, width / 3, height / 8, w)
i = 1
inputs.setpos(i, width / 30)
inputs.addstr("Input Parameters, expecting: #{exp_type}")

inputs.box('|', '-')
inputs.refresh

# table that displays what the user input parameters are,
# and actual and expected results when the function is ran
w = width / 4.25
table = Window.new(height / 4, width / 2, height / 4, w)

# Lord forgive us for this portion, for we know not what we do
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
table.setpos(2, width / 15)
table.addstr("_________")
table.refresh
b_column = table.derwin(height / 4, width / 15, 0, w / 2)
b_column.setpos(1, width / 11)
b_column.box('|', '-')
b_column.refresh
act_column = table.derwin(height / 4, 34, 0, w / 2)
act_column.setpos(1, width / 3)
act_column.box('|', '-')
act_column.refresh
table.setpos(1, 24)
table.addstr(" c ")
table.setpos(2, 21)
table.addstr("_________")
table.setpos(1, 38)
table.addstr(" actual ")
table.setpos(2, 31)
table.addstr("______________________")
table.setpos(1, 64)
table.addstr(" expected ")
table.setpos(2, 54)
table.addstr("________________________________")


table.box('|', '-')
table.refresh

# output window for potential error messages
output = Window.new(height / 4, width / 2, height / 2, w)

# window for help messages
display = Window.new(4, width - 5, height - 5, 5)
y_position = 4

# function that handles parameter entering, lexing and parsing
def param_eval(inputs, lex_string, table, act_expr, exp_expr, output, y, exp_type)
  # runtimes that run the user input function and the actual function for our program
  actual_runtime = Runtime.new
  expected_runtime = Runtime.new
  x = 2
  param_string = ""
  letter = 97
  loop do
    i = inputs.getch
    # backspace
    if i == 8 || i == 127
      inputs.clear
      inputs.setpos(1, (Curses.cols)/ 30)
      inputs.addstr("Input Parameters, expecting: #{exp_type}")
      inputs.box('|', '-')
      param_string.chop!
      inputs.setpos(3, 2)
      inputs.addstr(param_string)
      x -= 1
      inputs.refresh
    # enter
    elsif i == 10
      lex_string << "#{letter.chr} = #{param_string}"
      inputs.setpos(4,3)
      j = [4, 13, 22]
      current = 0
      exp_translate = ""
      actual_translate = ""
      # do the lexing and parsing, catch and display any errors that occur
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
        # lex the expected tokens
        exp_parse = nil
        exp_eval = nil
        exp_expr.each do |expression|
          lex = Lexer.new(expression)
          tokens = lex.lex_string
          exp_parse = Parser.new(tokens).parse
          exp_eval = exp_parse.visit(Evaluator.new(expected_runtime))
        end
        # lex the actual tokens
        act_parse = nil
        act_expr.each do |expression|
          if expression.eql?("")
            break
          end
          lex = Lexer.new(expression)
          tokens = lex.lex_string
          act_parse = Parser.new(tokens).parse
          act_parse.visit(Evaluator.new(actual_runtime))
        end
        table.setpos(y,60)
        exp_translate = exp_eval.visit(Translator.new).to_s
        actual_eval = act_parse.visit(Evaluator.new(actual_runtime))
        actual_translate = actual_eval.visit(Translator.new).to_s
        table.addstr(exp_translate)
        table.setpos(y, 40)
        table.addstr(actual_translate)
        if actual_translate.eql?(exp_translate)
          output.clear
          output.setpos(2, 3)
          output.addstr("Your function is correct!")
          output.refresh
        else
          output.clear
          output.setpos(2, 3)
          output.addstr("#{act_expr[0]} is not the correct function.")
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
    # if it is none of the special keys, display it in the parameter box
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
act_array = []
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
  # exit out of the main window
  if c == 'q'
    break
  # function mode
  elsif c == 'f'
    full_function = ""
    control = false
    act_expr = ""
    act_array = []
    function.clear
    function.setpos(1, width / 30)
    function.addstr("Enter your function guess here")
    function.box('|', '-')
    function.refresh
    mode = Modes::FUNCTION
    display.clear
    display.addstr(display_help_messages(mode))
    display.refresh
    y = 3
    x = 2
    # get the user input function
    loop do
      chr = function.getch
      # ctrl-c for windows, ctrl-d for mac to submit function
      if chr == 3 || chr == 4
        full_function = full_function.strip
        function.setpos(y + 1, 2)
        function.addstr("Guess has been entered.")
        function.refresh 
        mode = Modes::INPUT
        display.clear
        display.addstr(display_help_messages(mode))
        display.refresh
        act_array << act_expr
        break
      #backspace handling
      elsif chr == 8 || chr == 127
        if x > 2
          x -= 1
        else
          if y > 3
            y -= 1
            x = full_function.split("\n")[-1].length + 2
          end
        end
        function.clear
        function.setpos(1, (Curses.cols) / 30)
        function.addstr("Enter your function guess here")
        function.box('|', '-')
        full_function.chop!
        act_expr.chop!
        exprs = full_function.split("\n")
        exprs.each_with_index do |expr, index|
          function.setpos(3 + index, 2)
          function.addstr(expr)
        end
        function.setpos(y, x)
        function.refresh
      else
        full_function << chr
        act_expr << chr
        if chr == 10
          if act_expr.include?("function") || act_expr.include?("if") || act_expr.include?("while") || act_expr.include?("for")
            control = true
          end
          if act_expr.include?("end") && control
            act_array << act_expr.gsub(/[\r\n]+/, ' ')
            act_expr = ""
          end
          y += 1
          x = 1
          function.setpos(y, 2)
        else
          function.setpos(y, x)
          function.addch(chr)
        end
        x += 1
        function.refresh
      end
    end
    y_position = param_eval(inputs, lex_string, table, act_array, exp_expr, output, y_position, exp_type)
    mode = Modes::WAITING
  # input parameter mode
  elsif c == 'i'
    mode = Modes::INPUT
    display.clear
    display.addstr(display_help_messages(mode))
    display.refresh
    y_position = param_eval(inputs, lex_string, table, act_array, exp_expr, output, y_position, exp_type)
    mode = Modes::WAITING
  # invalid mode
  else
    mode = Modes::INVALID
  end
end

function.close
close_screen