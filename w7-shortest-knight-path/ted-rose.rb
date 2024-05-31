POSSIBLE_MOVES = {
  'up_left' => [-1, 2],
  'up_right' => [1, 2],
  'right_up' => [2, 1],
  'right_down' => [2, -1],
  'down_left' => [-1, -2],
  'down_right' => [1, -2],
  'left_up' => [-2, 1],
  'left_down' => [-2, -1],
}

def move_knight(path, finish)
  possible_paths = []
  start_letter = path[-1][0].ord - 'a'.ord + 1
  start_number = path[-1][1].to_i
  puts("start_letter: ", start_letter)
  puts("start_number: ", start_number)

  POSSIBLE_MOVES.each_value do |letter, number|
    possible_path = path
    new_letter = start_letter + letter
    new_number = start_number + number
    puts("\nnew_letter: ", new_letter)
    puts("new_number: ", new_number)
    puts("possible_paths:", possible_paths.inspect)

    if !new_letter.positive? or new_letter > 8 or !new_number.positive? or new_number > 8
      puts("Can't move outside the board!")
      next
    end

    new_position = (new_letter + 'a'.ord - 1).chr + new_number.to_s
    puts("new_position: ", new_position)
    if possible_path.include?(new_position)
      puts("Don't repeat your moves!")
      next
    end

    puts("new_position in move_knight:", new_position)
    possible_path << new_position
    puts("current path: #{possible_path.inspect}")

    if new_position == finish
      puts("Brought knight home!")
      possible_paths << possible_path
      break
    else
      puts("Looking for more possible_path's")
      some_possible_paths = move_knight(possible_path, finish)

      unless some_possible_paths == []
        puts("some_possible_paths wasn't empty:", some_possible_paths.inspect)
        possible_paths << some_possible_paths
      end

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

    # puts("possible_paths:\n#{possible_paths.inspect}")
    non_empty_arrays = remove_empty_arrays(possible_paths)
    non_empty_arrays.min_by(&:length)
    puts("Shortest path:\n#{non_empty_arrays.min_by(&:length).inspect}")

end
shortest_knight_path('a3', 'b4')
