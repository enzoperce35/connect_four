require_relative 'grid.rb'
require_relative 'input.rb'

class Game < Grid
  attr_accessor :player1, :player2, :grid, :board, :input, :turn_count,
                :game_won, :game_draw

  def initialize
    @grid = Grid.new
    @board = game_board
    @turn_count = 1
    @game_won = false
    @game_draw = false
    @player1 = "John" #prompt_player  #commented to give a default value "John" for rspec
    @player2 = "Mark" #prompt_player  #commented to give a default value "Mark" for rspec
  end

  #prompts users for their name
  def prompt_player
    puts "Who's playing"
    gets.chomp!
  end

  #draws the current game board status
  def game_board
    rows = String.new
    grid.horizontal.each do |line|
      line.each { |val| rows += val.encode('utf-8') }
      rows += "\n"
    end
    rows.reverse + "\n  1  2  3  4  5  6  7"
  end

  #initiates and ends the game
  def start
    while !game_won
      @input = next_turn

      redo unless input.is_valid
      grid.update(input)

      check_coordinates

      puts game_board, game_status

      break if game_draw

      @turn_count += 1
    end
  end

  #switches players everytime :turn_count is incremented
  def next_turn
    if turn_count.odd?
      Input.new(player1, "\u26BD ", grid)
    else
      Input.new(player2, "\u26D4 ", grid)
    end
  end

  #checks every grid to look for a possible 4 consecutive tokens
  def check_coordinates
    grid.instance_variables.each do |coord|
      coordinate = grid.instance_variable_get(coord)
      check_grid_lines(coordinate)
    end
  end

  def check_grid_lines(coordinate)
    connect_four = input.token * 4
    coordinate.each { |line| @game_won = true if line.join.include? connect_four }
    game_won
  end

  #outputs a message if the game is won or the game is draw
  def game_status
    if game_won
      "Game Over: #{input.player} wins!" if game_won
    elsif !game_won && turn_count == 42
      @game_draw = true
      "Game Over: the game is draw"
    end
  end
end
