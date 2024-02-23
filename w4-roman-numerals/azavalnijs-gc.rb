DIG_TO_ROMAN = {
  1000 => "M", 900 => "CM", 500 => "D", 400 => "CD",
  100 => "C", 90 => "XC", 50 => "L", 40 => "XL",
  10 => "X", 9 => "IX", 5 => "V", 4 => "IV", 1 => "I"
}

ROMAN_TO_DIG = DIG_TO_ROMAN.invert

def int_to_roman(number)
  DIG_TO_ROMAN.reduce("") do |res, (value, numeral)|
    count, number = number.divmod(value)
    res << numeral * count
  end
end

p int_to_roman(8)

def roman_to_int(roman)
  number = 0

  roman.each_char.each_cons(2) do |current, next_char|
    if ROMAN_TO_DIG[current] < ROMAN_TO_DIG[next_char]
      number -= ROMAN_TO_DIG[current]
    else
      number += ROMAN_TO_DIG[current]
    end
  end

  number + ROMAN_TO_DIG[roman[-1]]
end

p roman_to_int("MDCLXVI") 

# NEXT STOLEN FROM Munto (from Codewars)
roman.scan(/#{NUMS.keys.join('|')}/).inject(0) { |num, key| num + NUMS[key] }