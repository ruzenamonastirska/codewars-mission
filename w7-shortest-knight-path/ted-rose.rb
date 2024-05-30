POSSIBLE_MOVES = {
  'up_left' => [-1, 2],
  'up_right' => [1, 2],
  'right_up' => [2, 1],
  'down_left' => [-1, 2],
  'down_right' => [1, 2],
  'right_down' => [2, -1],
  'left_up' => [2, 1],
  'left_down' => [2, -1],
}

def move_knight(path, finish)
  possible_paths = []
  start_letter = path[-1][0].ord - 'a'.ord + 1
  start_number = path[-1][1].to_i

  POSSIBLE_MOVES.each_value do |letter, number|
    possible_path = path
    new_letter = start_letter + letter
    new_number = start_number + number
    next unless (new_letter.positive? && new_letter < 9) && (new_number.positive? && new_number < 9)

    new_position = (new_letter + 'a'.ord - 1).chr + new_number.to_s
    next if possible_path.include?(new_position)

    puts("\nnew_position in move_knight:", new_position)
    possible_path << new_position
    puts("current path: #{path.inspect}")
    if new_position == finish
      puts("Brought knight home!")
      possible_paths << path
      break
    else
      possible_paths << move_knight(possible_path, finish)
    end
  end
  possible_paths
end

def remove_empty_arrays(array)
  array.each_with_object([]) do |element, result|
    if element.is_a?(Array)
      cleaned_element = remove_empty_arrays(element)
      result << cleaned_element unless cleaned_element.empty?
    else
      result << element
    end
  end
end

def shortest_knight_path(start, finish)
    single_square_path = [start]
    possible_paths = move_knight(single_square_path, finish)
    # possible_paths << possible_paths
    # puts("Got this path from move_knight:\n#{possible_paths.inspect}")

    puts("possible_paths:\n#{possible_paths.inspect}")
    non_empty_arrays = remove_empty_arrays(possible_paths)
    non_empty_arrays.min_by(&:length)
    puts("Shortest path:\n#{non_empty_arrays.min_by(&:length).inspect}")

end
shortest_knight_path('a3', 'b4')
