def top_3_words(string)
  results = {}

  string.split(" ").map do |word|
    word.gsub!(/[^a-zA-Z']/, '')
    word.downcase!
    if word.match?(/[a-zA-Z]/)
      results[word] = results[word].to_i + 1
    end
  end

  sorted = results.sort_by{|_key, value| value }
  output = []
  [sorted.size, 3].min.times{ output << sorted.pop.first }
  output
end
