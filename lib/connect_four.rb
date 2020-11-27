require_relative 'grid.rb'

class Game < Grid
  attr_accessor :grid, :board, :new_input, :turn_count, :game_won

  def initialize
    @grid = Grid.new
    @board = draw_board
    @turn_count = 0
    @game_won = false
    @new_input = {}
  end

  def draw_board
    rows = String.new
    grid.horizontal.each do |line|
      line.each { |val| rows += val.encode('utf-8') }
      rows += "\n"
    end
    rows.reverse + "\n  1  2  3  4  5  6  7"
  end

  def start  
    while !game_won
      puts "#{player.keys[0]}'s turn, choose slot"
      new_input.store('input', gets.chomp!.to_i)

      valid_input? ? update_grids : redo
      status
      puts draw_board
      puts "Game Over: #{player.keys[0]} wins" if game_won
      @turn_count += 1
    end
  end

  def player
    player1 =  { PLAYER_1: "\u26BD " }
    player2 =  { PLAYER_2: "\u26D4 " }
    if turn_count.zero? || turn_count.even?
      player1
    else
      player2
    end
  end

  def valid_input?
    input = new_input.values[0]
    avail_slot = grid.vertical[input-1].count("\u26AA ")

    new_input[:row_num] = 6 - avail_slot
    new_input[:col_num] = input-1
    new_input[:rev_ind] = (input-7).abs  #reversed index for '#draw_board' return
    new_input[:unicode] = player.values[0]

    input.between?(1,7) && avail_slot > 0
  end

  def update_grids
    grid.update_horizontal(new_input[:rev_ind], new_input[:unicode])
    grid.update_vertical(new_input[:col_num], new_input[:unicode])
    grid.update_diagonal([new_input[:col_num], new_input[:row_num]], new_input[:unicode])
  end
  #ruby ./lib/connect_four.rb
  def status
    connect_four = player.values[0] * 4
    grid.horizontal.each { |line| @game_won = true if line.join.include? connect_four}
    grid.vertical.each { |line| @game_won = true if line.join.include? connect_four }
    grid.diagonal.each { |line| @game_won = true if line.join.include? connect_four}
    game_won
  end
end

x = Game.new
x.start