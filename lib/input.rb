class Input
  attr_accessor :player, :token, :input, :grid, :avail_vertical,
                :row_index, :column_index, :reversed_index, :is_valid

  def initialize(player, token, grid)
    @player = player
    @token = token
    @input = 3 #ask_input  #commented to give a default value 3 for rspec
    @grid = grid
    input_attributes
  end

  def ask_input
    inp = 0
    puts "#{player}'s turn: choose your slot, drop #{token}"
    inp = $stdin.gets.chomp!.to_i until inp.between?(1,7)
    inp
  end

  def input_attributes
    @avail_vertical = grid.vertical[input-1].count("\u26AA ")
    @column_index = 6 - avail_vertical
    @row_index = input - 1
    @reversed_index = (input-7).abs  #reversed index for '#board' display
    @is_valid = input.between?(1,7) && avail_vertical > 0
  end
end