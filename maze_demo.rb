require 'grid'
require 'optparse'
require 'binary_tree'
require 'sidewinder'
require 'distances_grid'

options = {
    height: 10,
    width: 10,
    solve: false,
    output: ['text'],
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

  opts.on('', '--[no-]text', 'Output maze as ASCII') do |o|
    if o == true
      options[:output] << 'text'
    else
      options[:output].delete('text')
    end
  end

  opts.on('', '--[no-]png', 'Output maze as png') do |o|
    if o == true
      options[:output] << 'png'
      options[:output_file] = 'maze.png'
    else
      options[:output].delete('png')
    end
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

options[:output].uniq.each do |type|
  case type
    when /text/ then puts grid
    when /png/
      grid.to_png.save options[:output_file]
      puts "Saved to #{options[:output_file]}"
  end
end

