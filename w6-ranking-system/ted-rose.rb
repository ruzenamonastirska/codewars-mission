class User
  attr_reader :rank
  attr_accessor :progress, :valid_ranks

  def initialize(rank = -8, progress = 0)
    @valid_ranks = [-8, -7, -6, -5, -4, -3, -2, -1, 1, 2, 3, 4, 5, 6, 7, 8]
    @rank = rank
    @progress = progress
  end

  def rank=(value)
    raise ArgumentError, 'Rank cannot be set to 0' unless @valid_ranks.include?(value)

    @rank = value
  end

  def evaluate_rank(user = self)
    if @progress >= 100
      @progress = [0, @progress - 100].max
      (user.rank = (@rank != -1 ? [8, @rank + 1].min : 1))
    end

    @progress = 0 if @rank == 8
    evaluate_rank if @progress > 99
  end

  def inc_progress(activity)
    diff = (activity.positive? ? activity - 1 : activity) - (@rank.positive? ? @rank - 1 : @rank)
    (@progress += 1) && evaluate_rank if diff == -1 && (@rank != 8)
    (@progress += 3) && evaluate_rank if diff.zero? && (@rank != 8)
    (@progress += 10 * (diff**2)) && evaluate_rank && (@rank != 8)
  end
end

def test(user, activity_rank)
  puts("\nactivity_rank = #{activity_rank}\nUser stats after activity accomplished:")
  user.inc_progress(activity_rank)
  puts("player_rank = #{user.rank}", "progress = #{user.progress}")
end

Ted = User.new

Ted.valid_ranks.each do |activity_rank|
  test(Ted, activity_rank)
end

test(Ted, 3)

begin
  User.new(rank: 10)
rescue ArgumentError
  puts("\nInvalid rank defined!")
end
