require 'grid'
require 'options'
require 'binary_tree'
require 'sidewinder'
require 'distances_grid'

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
  grid.distances = distances
end

options.output.uniq.each do |type|
  case type
    when /text/ then puts grid
    when /png/
      grid.to_png.save options.output_file
      puts "Saved to #{options.output_file}"
  end
end

