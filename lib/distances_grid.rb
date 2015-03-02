require 'grid'

class DistanceGrid < Grid
  attr_accessor :distances

  def contents_of(cell)
    if distances && distances[cell]
      cell.content.nil? ? distances[cell].to_s : cell.content
    else
      super
    end
  end
end