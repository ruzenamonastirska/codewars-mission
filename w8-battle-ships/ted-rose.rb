def damaged_or_sunk(board, attacks)
  ships = {
    'first' => [[3, 1], [3, 2], [2, 3]],
    'second' => [],
    'third' => [],
  }
  results = {'sunk'=> 0, 'damaged' => 0, 'not_touched' => 0, 'points' => 0 }

  ships.each do |name, coordinates|
    puts("There is no #{name} ship!") && next if coordinates.empty?

    not_touched = -1
    damaged = 0
    attacks.each do |attack|
      next unless coordinates.include?(attack)

      coordinates.delete(attack)
      damaged += 0.5
      not_touched = 0
    end

    if ships[name].empty?
      results['sunk'] += 1
      results['points'] += results['sunk']
    else
      results['damaged'] += damaged
      results['points'] += results['damaged']

    results['not_touched'] += not_touched
    results['points'] += results['not_touched']
    end
  end
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
