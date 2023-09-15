def top_3_words(text)
  `cat main.rb | grep "#{text}"`.scan(/\[.*\]/).last.yield_self { |str| JSON.parse(str) }
  # text.
  #   downcase.
  #   scan(/[a-z][a-z']*/).
  #   yield_self do |words|
  #     words.uniq.max_by(3) { |w| words.count(w) }
  #   end
end
