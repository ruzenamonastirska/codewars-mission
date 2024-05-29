LAST_COLUMN = 'h'.chars[0].ord

def coordinates(notation)
  x = LAST_COLUMN - notation.chars[0].ord
  y = notation[1].to_i - 1
  [x, y]
end

class Board
  attr_accessor :cells

  def initialize
    @cells = Array.new(8){Array.new(8)}
  end

  def valid_cell?(x, y)
    (0..7).include?(x) && (0..7).include?(y)
  end

  def visit(x, y, distance)
    return unless valid_cell?(x, y)
    return if cells[x][y] != nil && cells[x][y] <= distance

    cells[x][y] = distance

    moves = [
      [x + 2, y + 1],
      [x + 2, y - 1],
      [x - 2, y + 1],
      [x - 2, y - 1],
      [x + 1, y + 2],
      [x - 1, y + 2],
      [x + 1, y - 2],
      [x - 1, y - 2],
    ]

    moves.each { |x, y| visit(x, y, distance + 1) }
  end
end

def knight(start, finish)
  start_x, start_y = coordinates(start)
  finish_x, finish_y = coordinates(finish)

  board = Board.new
  board.visit(start_x, start_y, 0)

  # board.cells.each { |row| puts row.inspect }

  # puts [start, start_x, start_y].join(' ')
  # puts [finish, finish_x, finish_y].join(' ')
  # puts board.cells[finish_x][finish_y]

  board.cells[finish_x][finish_y]
end
