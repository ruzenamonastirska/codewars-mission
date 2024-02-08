class RomanNumerals
  def to_roman number
    convert_to_roman number
  end

  def from_roman string
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

  if number == 9
    return small + high
  end
  
  number -= 5
  mid + (small * number)
  end


# ==== From Roman to Integer ====


def convert_to_integer(string)

end
