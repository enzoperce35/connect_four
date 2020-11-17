class Connect_Four
  attr_accessor :player1

  def initialize
    @player1 = "\u26BD "
    @player2 = "\u26D4 "
    @game_board = draw_board("\u26AA ")
    @turn_count = 0
    @game_won = false
    @game_draw = false
  end

  def draw_board(unicode, row = [], board = { row1: '', row2: '', row3: '', row4: '', row5: '', row6: '' } )
    7.times { row << unicode }
    board.each_key { |key| board[key] = row}

    board
  end

end

test = Connect_Four.new

p test.draw_board("\u26AA ")
