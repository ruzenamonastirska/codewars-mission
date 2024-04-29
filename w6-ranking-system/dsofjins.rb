class User
  attr_accessor :rank, :progress

  def initialize
    @rank = -8
    @progress = 0
  end

  def inc_progress (puzzle_rank)
    raise ArgumentError unless (1..8).include?(puzzle_rank.abs)

    if puzzle_rank < self.rank
      diff = puzzle_rank - self.rank
    else
      diff = (puzzle_rank - self.rank).abs
    end
    if puzzle_rank * self.rank < 0 && self.rank < puzzle_rank
      diff -= 1
    end
    if diff == 0
      self.progress += 3
    elsif diff == -1
      self.progress += 1
    elsif diff < -1
      if self.rank > 0
        self.progress += 1
      else
        self.progress == 0
      end
    else
      self.progress += (10 * diff * diff)
    end

    while self.progress > 99 && self.rank != 0
      if self.rank == -1
        self.rank += 2
        self.progress -= 100
      else
        self.rank += 1
        self.progress -= 100
      end
    end
    if self.rank == 8
      self.progress = 0
    end
  end
end



