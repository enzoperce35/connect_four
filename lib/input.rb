class Input
  attr_accessor :player, :token, :input, :grid, :avail_vert, :row_index, :column_index, :reversed_index, :is_valid

  def initialize(player, token, grid)
    @player = player
    @token = token
    @input = prompt
    @grid = grid
    input_attributes
  end

  def prompt
    inp = 0
    puts "#{player}'s turn: choose your slot, drop #{token}"
    inp = gets.chomp!.to_i until inp.between?(1,7)
    inp
  end

  def input_attributes
    @avail_vert = grid.vertical[input-1].count("\u26AA ")
    @row_index = 6 - avail_vert
    @column_index = input - 1
    @reversed_index = (input-7).abs  #reversed index for '#draw_board' return
    @is_valid = input.between?(1,7) && avail_vert > 0
  end
end