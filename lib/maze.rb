libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'options'
require 'algorithms/sidewinder'
require 'distances_grid'
