# frozen_string_literal: true

require 'pry'
require 'pry-nav'
class User
  attr_accessor :progress
  attr_reader :rank

  def initialize
    self.rank = -8
    self.progress = 0
  end

  def rank=(rank)
    @rank = rank
    @rank += 1 if @rank.zero?
    @rank = 8 if @rank > 8
  end

  def inc_progress(activity_rank)
    raise 'Invalid rank error' if activity_rank < -8 or activity_rank.zero? or activity_rank > 8

    diff = activity_rank - rank
    diff -= 1 if activity_rank.positive? && rank.negative?
    if diff == -1
      self.progress += 1
    elsif diff.zero?
      self.progress += 3
    elsif diff >= 1
      self.progress += 10 * diff * diff
    end
    while self.progress >= 100
      self.rank += 1
      self.progress -= 100
    end
  end
end
