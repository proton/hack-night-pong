#!/bin/env ruby

require "io/console"
require "curses"

include Curses

@width  = 60
@height = 40

@scores = [0, 0]

@ball_x = 10
@ball_y = 10

$p1_pos = 3
$p2_pos = 5

@pwidth = 5

def update_map
@map = []
@map << "x" * (@width * 2 + 3)
@height.times do |y|
  @map << ("x" + " " * @width + "|" + " " * @width + "x")
end

@pwidth.times do |j|
  @map[$p1_pos + 1 + j][3] = "]"
  @map[$p2_pos + 1 + j][-3] = "["
end
@map << "x" * (@width * 2 + 3)

@map[@ball_y + 1][@ball_x + 1] = "o"
end

def redraw_map
setpos(0, 0)
@map.map { |row| addstr(row + "\n") }
#puts @map
#puts "aaa"
#puts "bbb"
#print "\r\r"
refresh
end

threads = []
threads << Thread.new do     
  init_screen
  loop do
    update_map # TODO: only if there are changes
    redraw_map
    sleep 0.5
    #p [111, $p1_pos]
  end
end

threads << Thread.new do
  loop do
    #p 333
    input = getch
    #raise "aaa"
    $p1_pos -= 1 if input.ord == 65
    $p1_pos += 1 if input.ord == 66
    #p [222, $p1_pos]

    #p [111, input, input.ord]
    #p input.ord
    exit if input=="\u0018" or input=="\u0003"
  end
end

threads.map(&:join)

close_screen
