require './lib/connect_four'

describe Game do
  #describe "#write_board" do
  #  it "returns a hash of unicodes" do
  #    game = Game.new
  #    expect(game.write_board).to eql( { row1: ["\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA "],
  #                                       row2: ["\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA "],
  #                                       row3: ["\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA "],
  #                                       row4: ["\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA "],
  #                                       row5: ["\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA "],
  #                                       row6: ["\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA "] } )
  #  end
  #end

  describe "#draw_board" do
    it "returns a virtual connect-four game board" do
      game = Game.new
      expect(game.draw_board).to eql("\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                                     "\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                                     "\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                                     "\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                                     "\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                                     "\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                                     "\n  1  2  3  4  5  6  7")
    end
  end

  #describe "#start" do
  #  it "returns the final result of the game" do
  #    game = Game.new
  #    game_won = true
  #    expect(game.start).to eql(true)
  #  end
  #end

  describe "#turn_player" do
    it "returns a dialogue for the next turn" do
      game = Game.new
      expect(game.turn_player).to eql({ PLAYER_1: "\u26BD " })
    end
  end

  describe "#valid?" do
    it "returns a boolean that determines if the input is valid" do
      game = Game.new
      expect(game.valid?(1)).to eql(true)
      expect(game.valid?(8)).to eql(false)
    end
  end

  describe "#drop" do
    it "converts the hash into a virtual connect_four board" do
      game = Game.new
      expect(game.drop(3)).to eql("\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                                  "\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                                  "\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                                  "\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                                  "\n ⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪"\
                                  "\n ⚪ ⚪ ⚽ ⚪ ⚪ ⚪ ⚪"\
                                  "\n  1  2  3  4  5  6  7")
    end
  end

  describe "#status" do
    it "checks if the game is over" do
      game = Game.new
      expect(game.status).to eql(false)
    end
  end


end