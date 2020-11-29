class Grid
  attr_accessor :horizontal, :vertical, :diagonal

  def initialize
    @horizontal = write_horizontal
    @vertical = write_vertical
    @diagonal = nil
  end

  def write_horizontal
    rows = [[],[],[],[],[],[]]
    rows.each do |row|
      7.times { row << "\u26AA " }
    end
    rows
  end

  def write_vertical
    columns = [[],[],[],[],[],[],[]]
    columns.each do |col|
      6.times { col << "\u26AA " }
    end
    columns
  end

  def update(input)
    update_horizontal(input.reversed_index, input.token)
    update_vertical(input.column_index, input.token)
    update_diagonal([input.column_index, input.row_index], input.token)
  end

  def update_horizontal(index, token)
    slot_found = false
    horizontal.each do |line|
      if line[index] == "\u26AA " && !slot_found
        line[index] = token
        slot_found
        break
      end
    end
  end

  def update_vertical(index, token)
    slot_found = false
    vertical[index].each_with_index do |slot,ind|
      if slot == "\u26AA " && !slot_found
        vertical[index][ind] = token
        slot_found
        break
      end
    end
  end

  def update_diagonal(input, token)
    @diagonal = [[],[]]
    check_sequences(input, token, 'forward')
    check_sequences(input, token, 'backward')
  end

  def diagonal_points(input, direction)
    return nil if input.nil?

    case direction
    when 'forward'
      [[input[0]+1,input[1]+1],[input[0]-1,input[1]-1]]
    when 'backward'
      [[input[0]-1,input[1]+1], [input[0]+1,input[1]-1]]
    end
  end

  def check_sequences(input, token, dir, queue = [], checked = [], dir2 = diagonal_points(input,dir))
    return nil if input.nil?

    2.times do |x|
      slot_attr = dir2.shift
      if slot_attr.all? { |attr| attr.between?(0,6) }
        queue << slot_attr if vertical[slot_attr[0]][slot_attr[1]] == token
      end
    end

    diagonal[dir == 'forward' ? 0 : 1] << token
    checked << input
    check_sequences((queue -= checked).shift, token, dir, queue, checked)
  end
end