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
end

#x = Grid.new
#puts x.display