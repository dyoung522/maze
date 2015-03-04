require 'distances'

class Cell
  attr_reader :row, :column
  attr_reader :north, :south, :east, :west
  attr_accessor :content

  def initialize(row, column)
    @row, @column = row, column
    @links = {}
  end

  def link(cell, bidi=true)
    @links[cell] = true
    cell.link(self, false) if bidi
    self
  end

  def unlink(cell, bidi=true)
    @links.delete(cell)
    cell.unlink(self, false) if bidi
    self
  end

  def links
    @links.keys
  end

  def linked?(cell)
    @links.key?(cell)
  end

  def east=(cell)
    return if cell == east
    @east = cell
    cell.west = self
  end

  def west=(cell)
    return if cell == west
    @west = cell
    cell.east = self
  end

  def north=(cell)
    return if cell == north
    @north = cell
    cell.south = self
  end

  def south=(cell)
    return if cell == south
    @south = cell
    cell.north = self
  end

  def neighbors
    list = []
    list << north if north
    list << south if south
    list << east if east
    list << west if west
    list
  end

  def distances
    distances = Distances.new(self)
    frontier = [ self ]

    while frontier.any?
      new_frontier = []

      frontier.each do |cell|
        cell.links.each do |linked|
          next if distances[linked]
          distances[linked] = distances[cell] + 1
          new_frontier << linked
        end
      end

      frontier = new_frontier
    end

    distances
  end
end