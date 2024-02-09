class RomanNumerals
  def self.to_roman number
    convert_to_roman number
  end

  def self.from_roman string
    convert_to_integer string
  end
end


# ==== From Integer to Roman ====


def convert_to_roman number
  raise "Number has to be a natural number." unless number.is_a? Integer and number > 0

  # split digits
  fractured = lambda {
    str_num = number.to_s
    { 
      thousands: str_num[0..-4].to_i || 0,
      hundreds: str_num[-3].to_i || 0,
      tens: str_num[-2].to_i || 0,
      ones: str_num[-1].to_i || 0,
    }
  }.call

  # write number in roman
  fractured_to_roman(fractured)
end


def fractured_to_roman(frac)
  result = ""

  result += "M" * (frac[:thousands] || 0)
  result += romanize(frac[:hundreds], "C", "D", "M")
  result += romanize(frac[:tens], "X", "L", "C")
  result += romanize(frac[:ones], "I", "V", "X")

  result
end


def romanize(number, small, mid, high)
  if number < 4
    return small * number
  end
  
  return small + mid if number == 4
  return mid if number == 5
  return small + high if number == 9

  number -= 5
  mid + (small * number)
  end


# ==== From Roman to Integer ====


def convert_to_integer(string)
  result = 0
  
  value = {
    "M" => 1000,
    "D" => 500,
    "C" => 100,
    "L" => 50,
    "X" => 10,
    "V" => 5,
    "I" => 1,
  }

  chars = string.chars
  last = chars.length - 1

  for i in 0..last
    if i != last
      value[chars[i]] >= value[chars[i + 1]] ? result += value[chars[i]] : result -= value[chars[i]]
    else
      result += value[chars[last]]
    end
  end

  result
end
