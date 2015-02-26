require 'grid'

class DistanceGrid < Grid
  attr_accessor :distances

  def contents_of(cell)
    if cell.distances && distances[cell]
      distances[cell].to_s(36)
    else
      super
    end
  end
end