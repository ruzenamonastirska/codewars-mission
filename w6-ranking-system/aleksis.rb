class User
  RANKS = ((-8..8).to_a - [0]).freeze

  def initialize
    @progress = 0
  end

  def inc_progress(activity_rank)
    raise unless RANKS.include?(activity_rank)

    case diff = rank_diff(activity_rank)
    when -1 then @progress += 1
    when 0 then @progress += 3
    when 1..Float::INFINITY then @progress += 10 * diff**2
    end
  end

  def rank
    RANKS[@progress / 100]
  end

  def progress
    rank == RANKS.last ? @zero.to_i : @progress % 100
  end

  private

  def rank_diff(activity_rank)
    RANKS.index(activity_rank) - RANKS.index(rank)
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
