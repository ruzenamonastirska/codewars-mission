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

class ChessMoves
  attr_accessor :path
  def initialize(path, iteration_depth)
    @path = path.dup
    @iteration_depth = iteration_depth + 1
  end

  def move_knight()
    current_letter = path[-1][0].ord - 'a'.ord + 1
    current_number = path[-1][1].to_i
    POSSIBLE_MOVES.each_value do |letter, number|
      puts("-------------------------------------------------------------------")
      puts("@iteration_depth: #{@iteration_depth}")
      print('@path.object_id: ')
      p path.object_id
      print("@path: ", @path.inspect, "\n")
      if (($shortest_path.length - path.length) < 2) && !$shortest_path.eql?([])
        puts("\e[38;5;214mWe won't find a shorter path!\e[0m")
        break
      end
      new_letter = current_letter + letter
      new_number = current_number + number
      new_position = (new_letter + 'a'.ord - 1).chr + new_number.to_s
      print('new_position: ', new_position, " by adding letter '", letter, "' and '", number, "'\n")

      if !new_letter.positive? or new_letter > 8 or !new_number.positive? or new_number > 8
        puts("\e[31mCan't move outside the board!\e[0m")
        next
      end

      if path.include?(new_position)
        puts("\e[31mDon't repeat your moves!\e[0m")
        next
      end

      next_path = path.dup << new_position
      print("next_path: #{next_path.inspect}\n")

      if new_position == $THE_FINISH
        puts("\e[32mBrought knight home!\e[0m")
        return next_path
      else
        puts("Looking for more possible path's")
        chess_moves = ChessMoves.new(next_path, @iteration_depth)
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

def knight(start, finish)
    $shortest_path = []
    single_square_path = [start]
    $THE_FINISH = finish.dup
    current_iteration_depth = 0
    chess_moves = ChessMoves.new(single_square_path, current_iteration_depth)
    print('chess_moves.object_id: ')
    p chess_moves.object_id
    the_shortest_path = chess_moves.move_knight()

    puts("the_shortest_path:\n#{the_shortest_path.inspect}")
    steps = the_shortest_path.length - 1
end

def codewars_test
  arr = [
    # ['a1', 'c1', 2],
    # ['a1', 'f1', 3],
    # ['a1', 'f3', 3],
    # ['a1', 'f4', 4],
    ['a1', 'f7', 5]
  ]

  arr.each do |start, finish, expected_steps|
    knight(start, finish).eql? expected_steps
  end
end

codewars_test