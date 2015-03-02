require 'distances'

describe Distances do
  before do
    @cell = Cell.new(0,0)
    @distances = Distances.new(@cell)
  end

  it '#[] returns distance to a cell' do
    expect(@distances[@cell]).to eq 0
  end

  it '#cells returns an array of cells' do
    expect(@distances.cells).to eq [@cell]
  end

  context '#path_to' do
    before do
      cell2 = Cell.new(0,1)
      cell2.link(@cell)
      @distances[cell2] = 1
      @path = @distances.path_to(cell2)
    end

    it 'returns a new Distances object' do
      expect(@path).to be_kind_of Distances
      expect(@path).not_to eq @distances
    end
  end

  context '#max' do
    it 'returns an array with a cell and the longest path' do
      cell2 = Cell.new(0,1)
      @distances[cell2] = 20
      expect(@distances.max).to eq [cell2, 20]
    end
  end

end