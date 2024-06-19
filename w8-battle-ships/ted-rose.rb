def find_ships(board)
  ships = [
    [],
    [],
    [],
  ]
  board_lines = board.length
  board.each_with_index do |row, row_index|
    puts("\n\nrow is:", row.inspect)
    puts("row_index is:", row_index)
    # Row numbering starts from the most bottom line
    row_number = board_lines - row_index

    row.each_with_index do |ship_number, column_number|
      puts("\nship_number:", ship_number)
      if ship_number.zero?
        puts("No ship on field [#{column_number}, #{row_number}]")
        next
      end

      ships[ship_number - 1] << [column_number + 1, row_number]
    end
  end
  puts("ships:", ships.inspect)
  ships
end

def damaged_or_sunk(board, attacks)
  ships = find_ships(board)
  results = {'sunk' => 0, 'damaged' => 0, 'not_touched' => 0, 'points' => 0 }

  ships.each_with_index do |coordinates, i|
    puts("\nShip coordinates:", coordinates.inspect)
    damaged = 0
    next if coordinates.empty?
    not_touched = 0

    attacks.each do |attack|
      next unless coordinates.include?(attack)

      coordinates.delete(attack)
      puts("Deleted coordinates")
      damaged = 0.5
      puts("damaged: #{damaged}")
    end
    puts("coordinates aftert deleting:", coordinates.inspect)

    if coordinates.empty?
      puts("Points because empty")
      results['sunk'] += 1
      results['points'] += 1
    elsif damaged.nonzero?
      puts("Points because not empty")
      results['damaged'] += 1
      results['points'] += damaged
    elsif damaged.zero?
      not_touched = 1
      results['points'] += - 1

    puts("damaged at end: #{damaged}")
    puts("not_touched: #{not_touched}")
    results['not_touched'] += not_touched

    end
  end
  puts("results", results)
  results
end


# # codewars tests
# board = [ [0, 0, 1, 0],
#           [0, 0, 1, 0],
#           [0, 0, 1, 0] ]
#
# attacks = [[3, 1], [3, 2], [3, 3]];
# result = damaged_or_sunk(board, attacks)
# puts"Game 1 result: { 'sunk': 1, 'damaged': 0 , 'not_touched': 0, 'points': 1}\n\n"

board = [ [3, 0, 1],
          [3, 0, 1],
          [0, 2, 1],
          [0, 2, 0] ]

attacks = [[2, 1], [2, 2], [ 3, 2], [3, 3]]
result = damaged_or_sunk(board, attacks)
p "Game 2 result: { 'sunk': 1, 'damaged': 1 , 'not_touched': 1, 'points': 0.5}"
