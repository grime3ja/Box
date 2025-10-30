require 'curses' # thus pottymouth
include Curses

init_screen
noecho
curs_set(0)

width = Curses.cols
height = Curses.lines

w = width / 2.75
function = Window.new(height / 8, width / 4, 0, w)
i = 1
function.setpos(i, width / 12)
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

loop do
  function.setpos(0, 0)
  c = function.getch
  if c == 'q'
    break
  elsif c == 10
    function.addstr("enter pressed")
    function.refresh
    sleep(1)
    break
  else
    # input_panel.clear
    # input_panel.addstr(c.ord.to_s)
  end
end

function.close
close_screen