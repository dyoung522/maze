require 'cell'

describe Cell do
  before do
    @cell = Cell.new(1,1)
    @cell2 = Cell.new(1,2)
    @cell.link(@cell2)
  end

  subject { Cell.new(1,1) }
  it { is_expected.to respond_to(:north, :south, :east, :west, :content) }

  context 'linking' do
    it 'links cells' do
      expect(@cell.linked?(@cell2)).to eq true
      expect(@cell2.linked?(@cell)).to eq true
    end

    it 'unlinks cells' do
      @cell.unlink(@cell2)
      expect(@cell.linked?(@cell2)).to eq false
      expect(@cell2.linked?(@cell)).to eq false
    end

    it 'provides a list of cells linked' do
      expect(@cell.links.last).to eq @cell2
      expect(@cell2.links.last).to eq @cell
    end
  end

  context '#neighbors' do

    it 'provides a list of neighbors' do
      @cell.east = @cell2
      expect(@cell.neighbors).to eq [@cell2]
      expect(@cell2.neighbors).to eq [@cell]
    end
  end

  context '#distances' do
    it 'returns a Distances object' do
      expect(@cell.distances).to be_kind_of Distances
    end
  end

  context '#content' do
    it 'sets cell contents' do
      @cell.content = 'test'
      expect(@cell.content).to eq 'test'
    end
  end

end
