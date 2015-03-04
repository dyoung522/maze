libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

Dir['lib/algorithms/*.rb'].each { |f| require "algorithms/#{File.basename(f, '.rb')}" }

require 'options'
require 'colored_grid'
require 'distances_grid'

