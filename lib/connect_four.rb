require_relative 'grid.rb'
require_relative 'input.rb'

class Game < Grid
  attr_accessor :player1, :player2, :grid, :board, :input, :turn_count, :game_won, :game_draw

  def initialize
    @grid = Grid.new
    @board = game_board
    @turn_count = 1
    @game_won = false
    @game_draw = false
    @player1 = prompt_player
    @player2 = prompt_player
  end

  def prompt_player
    puts "Who's playing"
    gets.chomp!
  end

  def game_board
    rows = String.new
    grid.horizontal.each do |line|
      line.each { |val| rows += val.encode('utf-8') }
      rows += "\n"
    end
    rows.reverse + "\n  1  2  3  4  5  6  7"
  end

  def start
    while !game_won
      @input = next_turn

      redo unless input.is_valid
      grid.update(input)

      win_check

      puts game_board, game_status

      break if game_draw

      @turn_count += 1
    end
  end

  def next_turn
    if turn_count.odd?
      Input.new(player1, "\u26BD ", grid)
    else
      Input.new(player2, "\u26D4 ", grid)
    end
  end

  def win_check
    connect_four = input.token * 4
    grid.instance_variables.each do |coordinate|
      coor = grid.instance_variable_get(coordinate)
      coor.each { |line| @game_won = true if line.join.include? connect_four}
    end
  end

  def game_status
    if game_won
      "Game Over: #{input.player} wins!" if game_won
    elsif !game_won && turn_count == 42
      @game_draw = true
      "Game Over: the game is draw"
    end
  end
end

connect_four = Game.new
connect_four.start