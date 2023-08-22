def top_3_words(text)
  def count_words(text)
    word_array = text.split(" ")
    word_occurences = Hash.new(0)
    word_array.each do |word|
      word_occurences[word] += 1
    end
    word_occurences
  end

  
  
  rankings = count_words(text).sort_by{ |k, v| v}.reverse
  rankings.keys.first(3)
  
end