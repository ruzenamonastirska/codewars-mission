def snail(array) 
  top = 0
  right = array.length-1
  bottom = array.length-1
  left = 0

  snail = []
  
  if array[0].length == 0
    return snail
  end
    
  while top <= bottom
    ver = top
    for hor in (left..right)
        snail.push(array[ver][hor])
    end
    
    top += 1
    
    hor = right
    for ver in (top..bottom)
      snail.push(array[ver][hor])
    end
    
    right -= 1
    
    ver = bottom
    for hor in (right).downto(left)
      snail.push(array[ver][hor])
    end
    
    bottom -=1
    
    hor = left
    for ver in (bottom).downto(top)
      snail.push(array[ver][hor])
    end
    left += 1
  end
  
  snail
  
end