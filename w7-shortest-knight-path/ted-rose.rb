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
POSSIBLE_PATHS = []

class ChessMoves
  def initialize(path)
    @path = path
  end

  def move_knight()
    current_letter = @path[-1][0].ord - 'a'.ord + 1
    current_number = @path[-1][1].to_i
    print("current_letter value: ", current_letter, "; ")
    print("current_number value: ", current_number, "\n")

    POSSIBLE_MOVES.each_value do |letter, number|
      current_thread_id = Thread.current.object_id
      puts "Current Thread ID: #{current_thread_id}"
      possible_path = @path
      new_letter = current_letter + letter
      new_number = current_number + number
      print("\nPOSSIBLE_PATHS:", POSSIBLE_PATHS.inspect, "\n")
      new_position = (new_letter + 'a'.ord - 1).chr + new_number.to_s
      print("new_position: ", new_position, " by adding letter '", letter, "' and '", number, "'\n")

      if !new_letter.positive? or new_letter > 8 or !new_number.positive? or new_number > 8
        puts("Can't move outside the board!")
        next
      end

      if possible_path.include?(new_position)
        puts("Don't repeat your moves!")
        next
      end

      possible_path << new_position
      print("current path: #{possible_path.inspect}\n")

      if new_position == $THE_FINISH
        puts("Brought knight home!")
        POSSIBLE_PATHS << possible_path
        break
      else
        puts("Looking for more possible_path's")
        chess_moves = ChessMoves.new(possible_path)
        some_possible_paths = self.move_knight()

        unless some_possible_paths == []
          puts("some_possible_paths wasn't empty:", some_possible_paths.inspect)
          POSSIBLE_PATHS << some_possible_paths
        end

      end
    end
    POSSIBLE_PATHS
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
    chess_moves = ChessMoves.new(single_square_path)
    possible_paths = chess_moves.move_knight()
    # possible_paths << possible_paths
    # puts("Got this path from move_knight:\n#{possible_paths.inspect}")

    # puts("possible_paths:\n#{possible_paths.inspect}")
    non_empty_arrays = remove_empty_arrays(possible_paths)
    non_empty_arrays.min_by(&:length)
    puts("Shortest path:\n#{non_empty_arrays.min_by(&:length).inspect}")

end
shortest_knight_path('a3', 'b4')
