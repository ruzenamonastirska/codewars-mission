# typed: false

ALLOWED_CHARS = (('a'..'z').to_a.concat ('A'..'Z').to_a.concat ["'", "-", " "]).join

def top_3_words text
  # Only allow accepted chars
  clean_text = text.chars.reject{|char| !(ALLOWED_CHARS.include? char)}.join

  # Get a list of words
  word_list = clean_text.split

  # Group words
  groups = word_list.group_by{|word| word.hash}

  # Count words
  counted_words = groups.values.map{|w_list| [w_list.length, w_list[0]]}

  # Sort it
  counted_words.sort_by!{|word| word[0]}

  # Return 3 most used words
  counted_words[-3..].map{|word| word[1]}
end

