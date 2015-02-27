require 'distances'

describe Distances do
  before do
    @cell1 = Cell.new(0,0)
    @distances = Distances.new(@cell1)
  end

  it '#[] returns distance to a cell' do
    expect(@distances[@cell1]).to eq 0
  end

  it '#cells returns an array of cells' do
    expect(@distances.cells).to eq [@cell1]
  end

  context '#path_to' do
    before do
      @cell2 = Cell.new(0,1)
      @cell2.link(@cell1)
      @distances[@cell2] = 1
      @path = @distances.path_to(@cell2)
    end

    it 'returns a new Distances object' do
      expect(@path).to be_kind_of Distances
      expect(@path).not_to eq @distances
    end
  end
end