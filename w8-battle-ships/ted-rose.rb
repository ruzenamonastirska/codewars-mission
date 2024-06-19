def find_ships(board)
  ships = { 1 => [], 2 => [], 3 => [] }
  board_rows = board.length
  board.each_with_index do |row, row_index|
    # Row numbering starts from the most bottom line
    row_number = board_rows - row_index
    row.each_with_index do |ship_number, column_index|
      next if ship_number.zero?
      
      # Indexing starts from 0 not 1 as column count on the board
      column_number = column_index + 1
      ships[ship_number] << [column_number, row_number]
    end
  end
  ships
end

def damaged_or_sunk(board, attacks)
  ships = find_ships(board)
  results = {'sunk' => 0, 'damaged' => 0, 'not_touched' => 0, 'points' => 0 }

  ships.each_with_index do |(_, coordinates), _|
    damaged = false
    next if coordinates.empty?

    attacks.each do |attack|
      next unless coordinates.include?(attack)

      coordinates.delete(attack)
      damaged = true
    end

    if coordinates.empty?
      results['sunk'] += 1
      results['points'] += 1
    elsif damaged
      results['damaged'] += 1
      results['points'] += 0.5
    elsif !damaged
      results['not_touched'] += 1
      results['points'] += - 1
    end
  end
  results
end

# codewars tests
board = [ [0, 0, 1, 0],
          [0, 0, 1, 0],
          [0, 0, 1, 0] ]

attacks = [[3, 1], [3, 2], [3, 3]];
result = damaged_or_sunk(board, attacks)
puts"Game 1 result: { 'sunk': 1, 'damaged': 0 , 'not_touched': 0, 'points': 1}\n\n"

board = [ [3, 0, 1],
          [3, 0, 1],
          [0, 2, 1],
          [0, 2, 0] ]

attacks = [[2, 1], [2, 2], [ 3, 2], [3, 3]]
result = damaged_or_sunk(board, attacks)
p "Game 2 result: { 'sunk': 1, 'damaged': 1 , 'not_touched': 1, 'points': 0.5}"
