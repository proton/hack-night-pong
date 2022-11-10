#!/bin/env ruby

require "io/console"
require "curses"

include Curses

@width  = 60
@height = 40

@scores = [0, 0]

@ball_x = 10
@ball_y = 10
@ball_dx = 1
@ball_dy = 1

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
  refresh
end

threads = []
threads << Thread.new do     
  init_screen
  loop do
    update_map # TODO: only if there are changes
    redraw_map
    sleep 0.1
  end
end

threads << Thread.new do
  loop do
    input = getch
    #raise "aaa"
    $p1_pos -= 1 if input.ord == 65
    $p1_pos += 1 if input.ord == 66
    exit if input=="\u0018" or input=="\u0003"
  end
end

threads << Thread.new do
  loop do
    @ball_x += @ball_dx
    @ball_y += @ball_dy
    sleep 0.3
  end
end

threads.map(&:join)

close_screen
