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