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

def test(user, activity_rank)
  puts("\nUser stats before activity accomplished:")
  puts("player_rank = #{user.rank}", "progress = #{user.progress}")
  user.inc_progress(activity_rank)
  puts("User stats after accomplished activity with rank '#{activity_rank}':")
  puts("player_rank = #{user.rank}", "progress = #{user.progress}")
  unless ((-8..8).to_a - [0]).include?(user.rank)
    puts('ERROR: Rank value is not in range -8,-7,-6,-5,-4,-3,-2,-1,1,2,3,4,5,6,7,8')
  end
end

Ted = User.new

puts("-------------------\nTest inc_progress:")
((-8..8).to_a - [0]).each do |activity_rank|
  test(Ted, activity_rank)
end

puts("\n\n-------------------\nTest too low activity:")
test(Ted, 3)

puts("\n\n-------------------\nTest invalid rank defined:")
begin
  bad_rank_user = Ted.rank(10)
  puts("\nAssigned bad_rank_user.rank = #{bad_rank_user.rank}!")
rescue ArgumentError
  puts("\nInvalid rank defined!")
end

puts("\n\n-------------------\nTest major progress increase:")
from_jun_to_senior = User.new
test(from_jun_to_senior, 8)