#!/bin/env ruby

@width  = 60
@height = 40

@scores = [0, 0]

@ball_x = 10
@ball_y = 10

@p1_pos = 3
@p2_pos = 5

@pwidth = 5

def update_map
@map = []
@map << "x" * (@width * 2 + 3)
@height.times do |y|
  @map << ("x" + " " * @width + "|" + " " * @width + "x")
end

@pwidth.times do |j|
  @map[@p1_pos + 1 + j][3] = "]"
  @map[@p2_pos + 1 + j][-3] = "["
end
@map << "x" * (@width * 2 + 3)

@map[@ball_y + 1][@ball_x + 1] = "o"
end

def redraw_map
puts "\e[H\e[2J"
puts @map
end

loop do
  update_map
  redraw_map
  sleep 0.1
end
