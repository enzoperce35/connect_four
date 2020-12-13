require './lib/grid'
require './lib/input'

describe Grid do

  subject(:grid) { described_class.new }
  let(:input) { Input.new('John', "\u26BD ", grid) }

  describe "#initialize" do
    context 'initializes the grid attributes' do
      it "@horizontal" do
        expect(grid.horizontal).to eq(grid.write_horizontal)
      end

      it "@vertical" do
        expect(grid.vertical).to eq(grid.write_vertical)
      end

      it "@diagonal" do
        expect(grid.diagonal).to eq(nil)
      end
    end
  end

  describe "#write_horizontal" do
    it "creates 6 array with 7 unicodes that represents a horizontal line" do
      expect(grid.write_horizontal).to eq([["\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA "],
                                           ["\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA "],
                                           ["\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA "],
                                           ["\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA "],
                                           ["\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA "],
                                           ["\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA "]])
    end
  end

  describe "#write_vertical" do
    it "creates 7 array with 6 unicodes that represents a vertical line" do
      expect(grid.write_vertical).to eq([["\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA ", "\u26AA "],
                                         ["\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA ", "\u26AA "],
                                         ["\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA ", "\u26AA "],
                                         ["\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA ", "\u26AA "],
                                         ["\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA ", "\u26AA "],
                                         ["\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA ", "\u26AA "],
                                         ["\u26AA ", "\u26AA ","\u26AA ", "\u26AA ","\u26AA ", "\u26AA "]])
    end
  end

  describe "#update" do
    it "receives update_horizontal" do
      expect(grid).to receive(:update_horizontal).with(input.reversed_index, input.token)
      grid.update(input)
    end

    it "receives update vertical" do
        expect(grid).to receive(:update_vertical).with(input.row_index, input.token)
        grid.update(input)
    end

    it "receives update diagonal" do
        expect(grid).to receive(:update_diagonal).with([input.row_index, input.column_index], input.token)
        grid.update(input)
    end
  end

  describe "#update_horizontal" do
    it 'updates the horizontal grid' do
        grid.update_horizontal(2, "\u26BD ")
        expect(grid.horizontal[0][2]).to eq("\u26BD ")
    end
  end

  describe "#update_vertical" do
    it 'updates the vertical grid' do
      grid.update_vertical(2, "\u26BD ")
      expect(grid.vertical[2][0]).to eq("\u26BD ")
    end
  end

  describe "#update_diagonal" do
    it 'updates the diagonal grid' do
      grid.diagonal = [[],[]]
      grid.update_diagonal(2, "\u26BD ")
      expect(grid.diagonal).to eq([["⚽ "], ["⚽ "]])
    end
  end

  describe "#diagonal_points" do
    context 'gets the successor and predecessor of an input in a diagonal line' do
      it 'gets the successor' do
        expect(grid.diagonal_points([2,3], 'forward')).to eq([[3, 4], [1, 2]])
      end

      it 'gets the predecessor' do
        expect(grid.diagonal_points([2,3], 'backward')).to eq([[1, 4], [3, 2]])
      end
    end
  end

  describe "#check_sequences" do
    before do
      grid.diagonal = [[],[]]
    end

    context 'checks for consecutive unicodes in a two directional diagonal line' do
      it 'checks the forward diagonal direction ' do
        input = [2,3]
        grid.vertical[3][4] = "\u26BD "
        grid.vertical[1][2] = "\u26BD "

        grid.check_sequences(input, "\u26BD ", 'forward')

        expect(grid.diagonal[0]).to eq(["⚽ ", "⚽ ", "⚽ "])
      end

      it 'checks the backward diagonal direction' do
        input = [2,3]
        grid.vertical[1][4] = "\u26BD "
        grid.vertical[3][2] = "\u26BD "
        grid.vertical[4][1] = "\u26BD "

        grid.check_sequences([2,3], "\u26BD ", 'backward')
        expect(grid.diagonal[1]).to eq(["⚽ ", "⚽ ", "⚽ ", "⚽ "])
      end
    end
  end

end