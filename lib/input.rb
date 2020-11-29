class Input
  attr_accessor :player, :token, :input, :grid, :avail_vertical,
                :row_index, :column_index, :reversed_index, :is_valid

  def initialize(player, token, grid)
    @player = player
    @token = token
    @input = prompt_player
    @grid = grid
    input_attributes
  end

  def prompt_player
    inp = 0
    puts "#{player}'s turn: choose your slot, drop #{token}"
    inp = gets.chomp!.to_i until inp.between?(1,7)
    inp
  end

  def input_attributes
    @avail_vertical = grid.vertical[input-1].count("\u26AA ")
    @row_index = 6 - avail_vertical
    @column_index = input - 1
    @reversed_index = (input-7).abs  #reversed index for '#board' display
    @is_valid = input.between?(1,7) && avail_vertical > 0
  end
end