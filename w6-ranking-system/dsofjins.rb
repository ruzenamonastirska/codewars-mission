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
    while @added_progress > 99 && @current_rank < 9
      if @current_rank == -1
        @current_rank += 2
        @added_progress -= 100
      else
        @current_rank += 1
        @added_progress -= 100
      end
    end
  end

  def inc_progress (puzzle_rank)
    if puzzle_rank < @current_rank
      diff = @current_rank - puzzle_rank
      @current_progress = 10 * diff * diff
    elsif puzzle_rank > @current_rank
      diff = puzzle_rank - @current_rank
      counted = 10 * diff * diff
      @current_progress += counted
    else
      puts "Please don't input 0!"
    end
  end
end