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

  def inc_progress(activity_rank)
    activity_in_positive_scale = 9 + (activity_rank.positive? ? activity_rank - 1 : activity_rank)
    @rank_in_positive_scale = 9 + (@rank.positive? ? @rank - 1 : @rank)
    difference = activity_in_positive_scale - @rank_in_positive_scale

    return puts('Progress not increased!') if difference.negative? || (@rank == 8)

    (@progress += 1) && evaluate_rank if difference == -1
    (@progress += 3) && evaluate_rank if difference.zero?
    (@progress += 10 * (difference**2)) && evaluate_rank
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
