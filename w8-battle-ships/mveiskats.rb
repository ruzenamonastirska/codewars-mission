# tally method was introduced in ruby 2.7 😭
Enumerable.define_method(:tally) do
  group_by(&:itself).transform_values(&:length)
end

def damaged_or_sunk(board, attacks)
  # Y coordinates are reversed - flip the board vertically
  board = board.reverse

  ship_sizes = board.flatten.reject(&:zero?).tally
  hits = attacks.map { |x, y| board[y - 1][x - 1] }.reject(&:zero?).tally

  sunk = damaged = not_touched = 0

  ship_sizes.each do |ship, size|
    if hits[ship] == size
      sunk += 1
    elsif hits[ship] && hits[ship] > 0
      damaged += 1
    else
      not_touched += 1
    end
  end

  {
    'sunk' => sunk,
    'damaged' => damaged,
    'not_touched' => not_touched,
    'points' => sunk + damaged * 0.5 - not_touched
  }
end
