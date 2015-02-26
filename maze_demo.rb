require 'grid'
require 'optparse'
require 'binary_tree'
require 'sidewinder'
require 'distances_grid'

options = {
    height: 10,
    width: 10,
    solve: false,
    output: 'text',
}
errors = []

OptionParser.new do |opts|
  opts.banner = "\nUsage: #{$0} [options]\n\n"

  opts.on('-?', '--help', 'Prints this help') do
    puts opts
    exit
  end

  opts.on('-w N', '--width=N', Integer, 'Width of Maze') do |o|
    if o > 100
      errors << 'Width too large.'
    else
      options[:width] = o
    end
  end

  opts.on('-h N', '--height=N', Integer, 'Height of Maze') do |o|
    if o > 100
      errors << 'Height too large.'
    else
      options[:height] = o
    end
  end

  opts.on('', '--[no-]solve', 'Show the solution') do |o|
    options[:solve] = o
  end

  opts.on('', '--[no-]solve', 'Show the solution') do |o|
    options[:solve] = o
  end

  opts.on('', '--png', 'Output maze as png') do |o|
    options[:output] = 'png'
    options[:output_file] = 'maze.png'
  end

end.parse!

if errors.any?
  errors.each { |error| puts error }
  exit 1
end

grid = DistanceGrid.new(options[:height], options[:width])

# BinaryTree.on(grid)
Sidewinder.on(grid)

if options[:solve]
  start = grid[0, 0]
  distances = start.distances
  grid.distances = distances
end

case options[:output]
  when 'text' then puts grid
  when 'png'
    puts "Saved to #{options[:output_file]}"
    grid.to_png.save options[:output_file]
end

