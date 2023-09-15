#!/usr/bin/env ruby

def each_word(io)
  io.scan(/[0-9A-Z']+/i).each { |word| yield word.downcase }
end

def top_3_words(input)
  occurences = {}

  each_word(input) do |word|
    occurences[word] ||= 0
    occurences[word] += 1
  end

  occurences.to_a
    .sort_by { |_word, count| -count }
    .first(3)
    .map { |word, _count| word }
end

input = ARGF.read()
puts top_3_words(input).join(", ")
