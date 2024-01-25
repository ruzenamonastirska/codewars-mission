def balanced_parens(n, opened=0, closed=0, str="", result=[])
  result << str if closed == n

  balanced_parens(n, opened + 1, closed, str + "(", result) if opened < n
  balanced_parens(n, opened, closed + 1, str + ")", result) if closed < opened

  result
end
