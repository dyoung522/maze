#!/usr/bin/env ruby

require_relative 'lib/maze'

defaults = {
    height: 10,
    width: 10,
    solve: false,
    output: ['text'],
}

options = Options.parse(defaults)

grid = DistanceGrid.new(options.height, options.width)

start = grid[0,0]
goal  = grid[grid.rows - 1, grid.columns - 1]

# BinaryTree.on(grid)
Sidewinder.on(grid)

if options.longest
  distances = start.distances
  new_start, distance = distances.max

  longest = new_start.distances
  goal, distance = longest.max
  grid.distances = longest.path_to(goal)
end

if options.solve
  distances = start.distances
  grid.distances = distances.path_to(goal)
end

options.output.uniq.each do |type|
  case type
    when /text/
      puts grid

    when /png/
      grid.to_png.save options.output_file
      puts "Saved to #{options.output_file}"
  end
end

private

def set_longest(grid)
  distances = grid[0,0].distances
  start, distance = distances.max
  start.content = 'S'

  longest = start.distances
  goal, distance = longest.max
  goal.content = 'G'

  grid.distances = longest.path_to(goal)
end

