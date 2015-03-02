require 'ostruct'
require 'optparse'

class Options
  def self.parse(defaults, args = ARGV)
    errors = []
    options = OpenStruct.new(defaults)

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
          options.width = o
        end
      end

      opts.on('-h N', '--height=N', Integer, 'Height of Maze') do |o|
        if o > 100
          errors << 'Height too large.'
        else
          options.height = o
        end
      end

      opts.on('', '--[no-]solve', 'Show the solution') do |o|
        options.solve = o
      end

      opts.on('', '--longest', 'Show the longest path') do |o|
        options.longest = o
      end

      opts.on('', '--[no-]text', 'Output maze as ASCII') do |o|
        if o == true
          options.output << 'text'
        else
          options.output.delete('text')
        end
      end

      opts.on('', '--[no-]png', 'Output maze as png') do |o|
        if o == true
          options.output << 'png'
          options.output_file = 'maze.png'
        else
          options.output.delete('png')
        end
      end
    end.parse!(args)

    if errors.any?
      errors.each { |error| puts error }
      exit 1
    end

    if options.output.empty?
      puts 'No output requested, defaulting to ASCII'
      options.output << 'text'
    end

    options
  end

end

