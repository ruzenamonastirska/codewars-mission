# it must support rank, progress and inc_progress(rank) methods
class User
  attr_accessor :current_rank, :current_progress, :added_progress

  def initialize
    @current_rank = -8
    @added_progress = 0
    @current_progress = 0
  end

  def rank
    puts "Users rank is #{@current_rank}"
  end

  def progress
    @added_progress += @current_progress
    while @added_progress > 99
      if @current_rank == -1
        @current_rank += 2
        @added_progress -= 100
      else
        @current_rank += 1
        @added_progress -= 100
      end
    end
    puts "Users current rank is #{@current_rank}"
  end

  def inc_progress (puzzle_rank)
    if puzzle_rank.is_a?(Integer)
      if puzzle_rank < @current_rank

        diff = @current_rank - puzzle_rank
        @current_progress = 10 * diff * diff
        return puzzle_rank
      elsif puzzle_rank > @current_rank
        diff = puzzle_rank - @current_rank
        counted = 10 * diff * diff
        @current_progress += counted
      else
        return "Please don't input 0!"
      end
    else
      return "Please input integer!"
    end
  end
end


user1 = User.new
user1.rank
user1.inc_progress(1) # will add 90 progress
user1.progress # => 0 # progress is now zero
user1.rank # => -7 # rank was upgraded to -7

