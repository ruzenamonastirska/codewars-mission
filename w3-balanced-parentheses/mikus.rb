def balanced_parens(n)
  n == 0 ? [""] : generate_parentheses(n, n).flatten.compact
end

def generate_parentheses(open, close, current = "", result = [])
  return current if close == 0

  [
    (generate_parentheses(open - 1, close, current + "(", result) if open > 0),
    (generate_parentheses(open, close - 1, current + ")", result) if close > open)
  ]
end