require './lib/main'
require './spec/spec_helper'

describe 'start' do

  subject(:game) { ConnectFour.new }

  before(:each) do
    expect(game).to receive(:board)
  end

  before(:all) do
    @original_stdout = $stdout
    $stdout = File.open(File::NULL, 'w')
  end

  context 'until game is won:' do
    before(:each) do
      allow(game).to receive(:won).and_return(false, false, false, true)
    end

    it "receive #next_turn" do
      input = Input.new('player', "\u26BD ", game.grid)
      expect(game).to receive(:next_turn).and_return(input)
      start(game)
    end

    it "receive #grid.update" do
      expect(game).to receive(:check_coordinates)
      expect(game.grid).to receive(:update).with(anything)
      start(game)
    end

    it "receive #check_coordinates" do
      expect(game).to receive(:check_coordinates)
      start(game)
    end

    it "receive and display #game_board" do
      expect(game).to receive(:game_board)  #added to receive it twice
      expect { start(game) }.to output(game.game_board).to_stdout
    end

    it "receive and display #game_status" do
      phrase = "\nGame Over: John wins!\n"
      expect { start(game) }.to output(phrase).to_stdout
    end

    it "increment #turn_count by 1" do
      start(game)
      expect(game.turn_count).to eq(2)
    end
  end

  context "if the game is draw:" do
    it "break the loop if game is draw" do
      allow(game).to receive(:turn_count).and_return(42)
      phrase = "\nGame Over: the game is draw\n"
      expect { start(game) }.to output(phrase).to_stdout
    end
  end
end