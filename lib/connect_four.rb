require_relative 'grid.rb'
require_relative 'input.rb'

class ConnectFour < Grid
  attr_accessor :player1, :player2, :grid, :game_board, :input, :turn_count,
                :won, :draw

  def initialize
    @grid = Grid.new
    @game_board = board
    @turn_count = 1
    @won = false
    @draw = false
    @player1 = "John" #prompt_player  #commented to give a default value "John" for rspec
    @player2 = "Mark" #prompt_player  #commented to give a default value "Mark" for rspec
  end

  #prompts users for their name
  def prompt_player
    puts "Who's playing"
    gets.chomp!
  end

  #draws the current game board status
  def board
    rows = String.new
    grid.horizontal.each do |line|
      line.each { |val| rows += val.encode('utf-8') }
      rows += "\n"
    end
    rows.reverse + "\n  1  2  3  4  5  6  7"
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
    coordinate.each { |line| @won = true if line.join.include? connect_four }
    won
  end

  #outputs a message if the game is won or the game is draw
  def status
    if won
      "Game Over: #{input.player} wins!" if won
    elsif !won && turn_count == 42
      @draw = true
      "Game Over: the game is draw"
    end
  end
end
