require_relative 'grid.rb'

class Game < Grid
  #attr_accessor :player1, :player2, :game_board, :turn_count, :game_won, :vertical, :horizontal, :diagonal
  attr_accessor :grid, :board, :new_input, :turn_count, :game_won, :player, :disc

  def initialize
    #@game_board = BOARD
    #@turn_count = 0
    #@vertical = [[],[],[],[],[],[],[]]
    #@horizontal = [[],[],[],[],[],[]]
    #@diagonal = []

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

      valid_input? ? drop : redo
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

    new_input.store('row_num', 6 - avail_slot)
    new_input.store('col_num', input-1)
    new_input.store('rev_ind', (input-7).abs)  #reversed index for '#draw_board' return

    input.between?(1,7) && avail_slot > 0
  end

  def drop
    #{"input"=>3, "row_num"=>0, "col_num"=>2, "rev_ind"=>4}

    row_index = new_input.values[1]
    column_index = new_input.values[2]
    reversed_index = new_input.values[3]

    horizontal_grid(reversed_index)
    vertical_grid(column_index)
    diagonal_grid([column_index, row_index])
  end

  def horizontal_grid(index)
    slot_found = false
    grid.horizontal.each do |line|
      if line[index] == "\u26AA " && !slot_found
        line[index] = player.values[0]
        slot_found
        break
      end
    end
  end

  def vertical_grid(index)
    slot_found = false
    grid.vertical[index].each_with_index do |slot,ind|
      if slot == "\u26AA " && !slot_found
        grid.vertical[index][ind] = player.values[0]
        slot_found
        break
      end
    end
  end

  def diagonal_grid(input)
    grid.diagonal = [[],[]]
    check_sequences(input, 'forward')
    check_sequences(input, 'backward')
  end

  def diagonal_points(input, dir)
    return nil if input.nil?
    if dir == 'forward'
      [[input[0]+1,input[1]+1],[input[0]-1,input[1]-1]]
    elsif dir == 'backward'
      [[input[0]-1,input[1]+1], [input[0]+1,input[1]-1]]
    end
  end

  def check_sequences(input, dir, queue = [], checked = [], dir2 = diagonal_points(input,dir))
    return nil if input.nil?

    2.times do |x|
      slot_attr = dir2.shift
      if slot_attr.all? { |attr| attr.between?(0,6) }
        queue << slot_attr if grid.vertical[slot_attr[0]][slot_attr[1]] == player.values[0]
      end
    end

    grid.diagonal[dir == 'forward' ? 0 : 1] << player.values[0]
    checked << input
    check_sequences((queue -= checked).shift, dir, queue, checked)
  end

  def status
    connect_four = player.values[0] * 4
    grid.horizontal.each { |line| @game_won = true if line.join.include? connect_four}
    grid.vertical.each { |line| @game_won = true if line.join.include? connect_four }
    grid.diagonal.each { |line| @game_won = true if line.join.include? connect_four}
    game_won
  end
end