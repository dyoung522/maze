require 'cell'

describe Cell do
  before do
    @cell1 = Cell.new(1,1)
    @cell2 = Cell.new(1,2)
    @cell1.link(@cell2)
  end

  subject { Cell.new(1,1) }
  it { is_expected.to respond_to(:north, :south, :east, :west) }

  context 'linking' do
    it 'links cells' do
      expect(@cell1.linked?(@cell2)).to eq true
      expect(@cell2.linked?(@cell1)).to eq true
    end

    it 'unlinks cells' do
      @cell1.unlink(@cell2)
      expect(@cell1.linked?(@cell2)).to eq false
      expect(@cell2.linked?(@cell1)).to eq false
    end

    it 'provides a list of cells linked' do
      expect(@cell1.links.last).to eq @cell2
      expect(@cell2.links.last).to eq @cell1
    end
  end

  context '#neighbors' do

    it 'provides a list of neighbors' do
      @cell1.east = @cell2
      expect(@cell1.neighbors).to eq [@cell2]
      expect(@cell2.neighbors).to eq [@cell1]
    end
  end

  context '#distances' do
    it 'returns a Distances object' do
      expect(@cell1.distances).to be_kind_of Distances
    end
  end
end
