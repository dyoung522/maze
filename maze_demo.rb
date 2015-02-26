require 'grid'
require 'optparse'
require 'binary_tree'
require 'sidewinder'
require 'distances_grid'

options = { height: 5, width: 5 }

OptionParser.new do |opts|
  opts.banner = "\nUsage: #{$0} [options]\n\n"

  opts.on('-?', '--help', 'Prints this help') do
    puts opts
    exit
  end

  opts.on('-w N', '--width=N', 'Width of Maze') do |o|
    options[:width] = o.to_i
  end

  opts.on('-h N', '--height=N', 'Height of Maze') do |o|
    options[:height] = o.to_i
  end
end.parse!

grid = DistanceGrid.new(options[:height], options[:width])

# BinaryTree.on(grid)
Sidewinder.on(grid)

start = grid[0, 0]
distances = start.distances
grid.distances = distances

puts grid
# grid.to_png.save 'maze.png'