# DOES NOT WORK CORRECTLY :(
# good till about 13
# not efficient!!

def all_ways_to_balance n
  raise "Number of parentheses can't have fractions!" unless n.is_a? Integer
  return [""] if n < 1

  insiders(n).uniq
end

def insiders n, perm = "", list = []
  if n == 0
    list << perm
    return
  end
  insiders(n - 1, "(#{perm})", list)
  insiders(n - 1, "#{perm}()", list)
  insiders(n - 1, "()#{perm}", list)
  list 
end

