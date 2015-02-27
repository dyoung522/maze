require 'grid'

describe Grid do
  before do
    @grid = Grid.new(2,2)
  end
  subject { @grid }

  it { is_expected.to respond_to(:contents_of, :each_row, :each_cell) }

  context '#initialize' do
    it 'should prepare the grid' do
      expect(@grid[0,0]).to be_kind_of Cell
      expect(@grid[0,1]).to be_kind_of Cell
      expect(@grid[1,0]).to be_kind_of Cell
      expect(@grid[1,1]).to be_kind_of Cell
    end

    it 'should set all neighbors' do
      expect(@grid[0,0].east).to eq @grid[0,1]
      expect(@grid[0,0].south).to eq @grid[1,0]

      expect(@grid[0,1].south).to eq @grid[1,1]
      expect(@grid[0,1].west).to eq @grid[0,0]

      expect(@grid[1,0].north).to eq @grid[0,0]
      expect(@grid[1,0].east).to eq @grid[1,1]

      expect(@grid[1,1].north).to eq @grid[0,1]
      expect(@grid[1,1].west).to eq @grid[1,0]
    end
  end

  context '#row_count' do
    it 'should return the number of rows' do
      expect(@grid.instance_eval{row_count(0)}).to eq 2
    end
  end
  context '#size' do
    it 'should return the grid size' do
      expect(@grid.size).to eq 4
    end
  end

  context 'output' do
    it '#to_s should draw an ASCII grid' do
      expect(@grid.to_s).to eq "+----+----+\n|    |    |\n" * 2 + "+----+----+\n"
    end

    it '#to_png should return an image' do
      expect(@grid.to_png).to be_kind_of ChunkyPNG::Image
    end
  end

end