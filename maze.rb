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

# BinaryTree.on(grid)
Sidewinder.on(grid)

if options.solve
  start = grid[0, 0]
  distances = start.distances
  # grid.distances = distances
  grid.distances = distances.path_to(grid[grid.rows - 1, 0])
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

