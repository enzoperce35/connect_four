require './lib/connect_four'
require './lib/grid'
require './lib/input'
require './spec/spec_helper'


describe Game do

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

  describe "#start" do
    before(:each) do
      expect(game).to receive(:game_board)
    end

    context 'until game is won, do:' do
      before(:each) do
        allow(game).to receive(:game_won).and_return(false, false, false, true)
      end

      it "receive #next_turn" do
        input = Input.new('player', "\u26BD ", game.grid)
        expect(game).to receive(:next_turn).and_return(input)
        game.start
      end

      it "receive #grid.update" do
        expect(game).to receive(:check_coordinates)
        expect(game.grid).to receive(:update).with(anything)
        game.start
      end

      it "receive #check_coordinates" do
        expect(game).to receive(:check_coordinates)
        game.start
      end

      it "receive and display #game_board" do
        expect(game).to receive(:game_board)  #added to receive it twice
        expect { game.start }.to output(game.game_board).to_stdout
      end

      it "receive and display #game_status" do
        phrase = "\nGame Over: John wins!\n"
        expect { game.start }.to output(phrase).to_stdout
      end

      it "increment #turn_count by 1" do
        game.start
        expect(game.turn_count).to eq(2)
      end
    end

    context "if game is draw, do:" do
      it "break the loop if game is draw" do
        allow(game).to receive(:turn_count).and_return(42)
        phrase = "\nGame Over: the game is draw\n"
        expect { game.start }.to output(phrase).to_stdout
      end
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
    it "get the necessary arguments then call the check_grid_lines method" do
      allow(game).to receive(:check_grid_lines)
      expect(game.grid).to receive(:instance_variable_get).exactly(3).times
      game.check_coordinates
    end
  end

  describe "#check_grid_lines" do
    before do
      game.input = Input.new('player', "\u26BD ", game.grid)
    end

    it "returns false if the @game_won is false" do
      expect(game.check_grid_lines(game.grid.vertical)).to be_falsey
    end

    it "returns true if the @game_won is true" do
      game.grid.vertical[3] = ["⚽ ", "⚽ ", "⚽ ", "⚽ ", "⚪ ", "⚪ "]

      expect(game.check_grid_lines(game.grid.vertical)).to be_truthy
    end
  end
end