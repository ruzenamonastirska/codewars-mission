def score(dice)
  score = 0

  counts = Hash.new(0)
  dice.each do |value|
    counts[value] += 1
  end

  (1..6).each do |number|
    if counts[number] >= 3
      score += (number == 1 ? 1000 : number * 100)
      counts[number] -= 3
    end
  end

  score += counts[1] * 100
  score += counts[5] * 50

  score
end
