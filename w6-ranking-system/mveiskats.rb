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
test(Ted, -8)

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
