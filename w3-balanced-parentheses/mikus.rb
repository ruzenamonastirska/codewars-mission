def balanced_parens(n)
  n == 0 ? [""] : generate_parentheses(n, n).flatten.compact
end

def generate_parentheses(open, close, current = "")
  return current  if  close == 0

  [
    (generate_parentheses(open - 1, close, current + "(") if open > 0),
    (generate_parentheses(open, close - 1, current + ")") if close > open)
  ]
end