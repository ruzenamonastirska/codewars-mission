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
$shortest_path = []

class ChessMoves
  def initialize(path, iteration_depth)
    @path = path
    @iteration_depth = iteration_depth + 1
  end

  def move_knight()
    puts("\n#{"#" * 170}")
    puts("move_knight called for the #{@iteration_depth} time!")
    current_letter = @path[-1][0].ord - 'a'.ord + 1
    current_number = @path[-1][1].to_i
    POSSIBLE_MOVES.each_value do |letter, number|
      puts("-------------------------------------------------------------------")
      puts("@iteration_depth: #{@iteration_depth}")
      current_path = @path
      print('@path.object_id: ')
      p @path.object_id
      # puts("$shortest_path.length: ", $shortest_path.length)
      # puts("current_path.length: ", current_path.length)
      if ($shortest_path.length - current_path.length) == 1
        puts('Brought knight home on the next move!')
        break
      end
      new_letter = current_letter + letter
      new_number = current_number + number
      print("$shortest_path: ", $shortest_path.inspect, "\n")
      new_position = (new_letter + 'a'.ord - 1).chr + new_number.to_s
      print('new_position: ', new_position, " by adding letter '", letter, "' and '", number, "'\n")

      if !new_letter.positive? or new_letter > 8 or !new_number.positive? or new_number > 8
        puts("Can't move outside the board!")
        next
      end

      if current_path.include?(new_position)
        puts("Don't repeat your moves!")
        next
      end

      current_path << new_position
      print("current_path: #{current_path.inspect}\n")

      if new_position == $THE_FINISH
        puts('Brought knight home!')
        return current_path
      else
        puts("Looking for more possible path's")
        chess_moves = ChessMoves.new(current_path, @iteration_depth)
        print('chess_moves.object_id: ')
        p chess_moves.object_id
        current_shortest_path = chess_moves.move_knight
        unless current_shortest_path == []
          puts("current_shortest_path wasn't empty")

          unless ($shortest_path.length < current_shortest_path.length) && ($shortest_path.length.nonzero?)
            puts('Found a shorter path!')
            $shortest_path = current_shortest_path
          end

        end


      end
    end
    $shortest_path
  end
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
    $THE_FINISH = finish
    current_iteration_depth = 0
    chess_moves = ChessMoves.new(single_square_path, current_iteration_depth)
    print('chess_moves.object_id: ')
    p chess_moves.object_id
    possible_paths = chess_moves.move_knight()
    # possible_paths << possible_paths
    # puts("Got this path from move_knight:\n#{possible_paths.inspect}")

    # puts("possible_paths:\n#{possible_paths.inspect}")
    non_empty_arrays = remove_empty_arrays(possible_paths)
    non_empty_arrays.min_by(&:length)
    puts("Shortest path:\n#{non_empty_arrays.min_by(&:length).inspect}")

end
shortest_knight_path('a3', 'c7')
