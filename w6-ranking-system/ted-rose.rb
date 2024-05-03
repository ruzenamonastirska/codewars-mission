class User
  attr_accessor :progress, :valid_ranks, :rank

  def initialize
    @valid_ranks = [-8, -7, -6, -5, -4, -3, -2, -1, 1, 2, 3, 4, 5, 6, 7, 8]
    @rank = -8
    @progress = 0
  end

  def evaluate_rank(user = self)
    if @progress >= 100
      @progress = [0, @progress - 100].max
      user.rank = (@rank != -1 ? [8, @rank + 1].min : 1)
    end
    @progress > 99 ? evaluate_rank : (@progress = 0 if @rank == 8)
  end

  def inc_progress(activity)
    raise ArgumentError unless @valid_ranks.include?(activity) || activity.nil?

    diff = (activity.positive? ? activity - 1 : activity) - (@rank > 0 ? @rank - 1 : @rank)
    (@progress += 1) && evaluate_rank if diff == -1 && (@rank != 8)
    (@progress += 3) && evaluate_rank if diff.zero? && (@rank != 8)
    (@progress += 10 * (diff**2)) && evaluate_rank && (@rank != 8) if diff > -1
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
