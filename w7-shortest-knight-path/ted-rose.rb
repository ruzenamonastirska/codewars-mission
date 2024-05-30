

def move_knight(path, finish)
  possible_moves = {
    'up_left' => [-1, 2],
    'up_right' => [1, 2],
    'right_up' => [2, 1],
    'down_left' => [-1, 2],
    'down_right' => [1, 2],
    'right_down' => [2, -1],
    'left_up' => [2, 1],
    'left_down' => [2, -1],
  }
  possible_paths = []


  start_letter = path[-1][0].ord - 'a'.ord + 1
  start_number = path[-1][1].to_i

  puts(start_letter)
  puts(start_number)

  possible_moves.each_value do |letter, number|
    new_letter = start_letter + letter
    new_number = start_number + number
    next unless (new_letter.positive? && new_letter < 9) && (new_number.positive? && new_number < 9)

    new_position = (new_letter + 'a'.ord - 1).chr + new_number.to_s
    puts("\nnew_position in move_knight:", new_position)
    path << new_position
    puts("current path: #{path.inspect}")
    if new_position == finish
      puts("Brought knight home!")
      possible_paths << path
      next
    end
  end
  possible_paths
end

def shortest_knight_path(start, finish)
  possible_moves = {
    'up_left' => [-1, 2],
    'up_right' => [1, 2],
    'right_up' => [2, 1],
    'down_left' => [-1, 2],
    'down_right' => [1, 2],
    'right_down' => [2, -1],
    'left_up' => [2, 1],
    'left_down' => [2, -1],
  }

  possible_paths = []
  start_letter = start[0].ord - 'a'.ord + 1
  start_number = start[1].to_i
  finish_letter = finish[0].ord - 'a'.ord + 1
  finish_number = finish[1].to_i

  puts(start_letter)
  puts(start_number)
  puts(finish_letter)
  puts(finish_number, "\n")

  possible_moves.each_value do |letter, number|
    new_letter = start_letter + letter
    new_number = start_number + number
    next unless (new_letter.positive? && new_letter < 9) && (new_number.positive? && new_number < 9)

    new_position = (new_letter + 'a'.ord - 1).chr + new_number.to_s
    puts("\nnew_position in main function: ", new_position)
    path = [start, new_position]
    if new_position == finish
      possible_paths << path
      next
    else
      some_possible_paths = move_knight(path, finish)
      possible_paths << some_possible_paths
      puts("Got this path from move_knight:\n#{possible_paths.inspect}")
    end
    puts("possible_paths:\n#{possible_paths.inspect}")
    non_empty_arrays = possible_paths.flatten(1).reject(&:empty?)
    non_empty_arrays.min_by(&:length)
    puts("Shortest path:\n#{non_empty_arrays.min_by(&:length).inspect}")

  end
end
shortest_knight_path('a3', 'd4')
