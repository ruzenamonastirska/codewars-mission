class User

  attr_reader :ranks, :progress

  def initialize
    @ranks = [(-8..-1).to_a, (1..8).to_a]
    @rank = 0
    @progress = 0
    @RANKUP_PROGRESS = 100
  end

  def rank
    @ranks[@rank]
  end

  def inc_progress(activity_rank)
    raise InvalidRankError unless ranks.include?(activity_rank)
      
    if ranks.index(activity_rank) == @rank
      rank_progress(3)
    elsif ranks.index(activity_rank) == @rank - 1
      rank_progress(1)
    elsif ranks.index(activity_rank) <= @rank - 2
      return
    elsif ranks.index(activity_rank) > @rank
      diff = ranks.index(activity_rank) - @rank
      progress_amount = 10 * diff * diff
      rank_progress(progress_amount)
    end
  end

  private

  def rank_up
    if progress >= RANKUP_PROGRESS
      @rank += 1
      @progress -= RANKUP_PROGRESS

      rank_up()
    end
  end

  def rank_progress(amount)
    if @rank != ranks.lenght
      @progress += amount

      rank_up()
    end
      @progress = 0
  end
end


class InvalidRankError < Exception; end

puts User.new.ranks
