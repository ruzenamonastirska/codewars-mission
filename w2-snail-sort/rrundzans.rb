def walk(arr, start: 0)
  full_w = arr[0].size
  layers_removed = start
  current_layer_w = full_w - layers_removed*2

  if current_layer_w == 0
    []
  elsif current_layer_w == 1
    [arr[start][start]]
  else
    top_to_bottom_walk = []
    bottom_to_top_walk = []

    (current_layer_w-2).times do |i|
      top_to_bottom_walk.push    arr[start+i+1][start+current_layer_w-1]
      bottom_to_top_walk.unshift arr[start+i+1][start]
    end

    output = []
    output.concat arr[start][start, current_layer_w] # top walk
    output.concat top_to_bottom_walk
    output.concat arr[start+current_layer_w-1][start, current_layer_w].reverse # bottom walk
    output.concat bottom_to_top_walk

    if current_layer_w > 2
      output.concat(walk(arr, start: start+1))
    end

    output
  end
end

alias snail walk
