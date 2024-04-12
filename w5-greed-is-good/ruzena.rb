def score( dice )
  # 1 1 1
  if dice.select { |d| d == 1}.count >= 3
    3.times do
      dice.delete_at(dice.index(1))
    end
    return 1000 + score(dice)
  end

  # x x x

  [*2..6].each do |n|
    if dice.select{|d| d == n }.count >= 3
      3.times do
        dice.delete_at(dice.index(n))
      end
      return n*100 + score(dice)
    end
  end

  # 1
  if [1, 2].include?(dice.select { |d| d == 1 }.count)
    count = dice.select{ |d| d == 1}.count
    count.times do
      dice.delete_at(dice.index(1))
    end
    return count * 100 + score(dice)
  end
  # 5
  if [1, 2].include?(dice.select { |d| d == 5 }.count)
    count = dice.select{ |d| d == 5}.count
    count.times do
      dice.delete_at(dice.index(5))
    end
    return count * 50 + score(dice)
  end
  return 0
end