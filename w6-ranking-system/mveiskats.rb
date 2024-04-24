class User
  attr_accessor :rank, :progress

  def initialize
    @rank = -8
    @progress = 0
  end

  def inc_progress(task_rank)
    raise ArgumentError unless (1..8).include? task_rank.abs

    # Add 1 to negative ranks to eliminate zero gap
    delta_rank = (task_rank + (task_rank < 0 ? 1 : 0)) - (rank + (rank < 0 ? 1 : 0))
    self.progress +=
      case delta_rank
      when -1 then 1
      when  0 then 3
      else
        [0, 10 * delta_rank * delta_rank].max
      end

    while self.progress >= 100
      self.rank += 1
      self.rank += 1 if self.rank == 0
      self.rank = [self.rank, 8].min

      self.progress -= 100
    end
    self.progress = 0 if self.rank == 8
  end
end
