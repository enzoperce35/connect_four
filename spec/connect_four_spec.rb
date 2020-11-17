require './lib/connect_four'

describe Connect_Four do
  describe "#draw_board" do
    it "returns a hash of unicodes that prints a virtual board game" do
      game = Connect_Four.new
      expect(game.draw_board("\u26AA ")).to eql( { row1: ["\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA "],
                                                  row2: ["\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA "],
                                                  row3: ["\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA "],
                                                  row4: ["\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA "],
                                                  row5: ["\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA "],
                                                  row6: ["\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA ", "\u26AA "] } )
    end
  end
end