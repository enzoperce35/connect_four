require './lib/connect_four'
require './spec/spec_helper'


describe ConnectFour do

  subject(:game) { described_class.new }

  before(:all) do
    @original_stdout = $stdout
    $stdout = File.open(File::NULL, 'w')
  end

  describe "#prompt_player" do
    it "asks for the player's name" do
      allow(game).to receive(:gets).and_return('John')
      phrase = "Who's playing\n"
      expect { game.prompt_player }.to output(phrase).to_stdout
    end
  end

  describe "#game_board" do
    it "returns a display of the game board" do
      expect(game.board).to eq("\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                               "\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                               "\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                               "\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                               "\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                               "\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                               "\n  1  2  3  4  5  6  7")
    end
  end

  describe "#next_turn" do
    context "switches the players and create new input values every turn count" do
      it "switches to player 1" do
        game.input = game.next_turn

        expect(game.input.token).to eq("\u26BD ")
      end

      it "switches to player 2" do
        game.turn_count = 2
        game.input = game.next_turn

        expect(game.input.token).to eq("\u26D4 ")
      end
    end
  end

  describe "#check_coordinates" do
    it "get the necessary arguments #check_grid_lines" do
      allow(game).to receive(:check_grid_lines)
      expect(game.grid).to receive(:instance_variable_get).exactly(3).times
      game.check_coordinates
    end
  end

  describe "#check_grid_lines" do
    before do
      game.input = Input.new('player', "\u26BD ", game.grid)
    end

    it "returns false if the @won is false" do
      expect(game.check_grid_lines(game.grid.vertical)).to be_falsey
    end

    it "returns true if the @won is true" do
      game.grid.vertical[3] = ["⚽ ", "⚽ ", "⚽ ", "⚽ ", "⚪ ", "⚪ "]

      expect(game.check_grid_lines(game.grid.vertical)).to be_truthy
    end
  end
end
