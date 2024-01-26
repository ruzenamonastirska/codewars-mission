def balanced_parens(n, opened=0, closed=0, str="", result=[])
  result << str if closed == n

  balanced_parens(n, opened + 1, closed, str + "(", result) if opened < n
  balanced_parens(n, opened, closed + 1, str + ")", result) if closed < opened

  result
end

# more elegant if you are a code golfer
def bp(n, opened=0, closed=0, str="")
  return str if closed == n

  [ *(bp(n, opened + 1, closed, str + "(") if opened < n),
    *(bp(n, opened, closed + 1, str + ")") if closed < opened) ]
end

p balanced_parens(3)
p bp(3)