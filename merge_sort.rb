def merge_sort(array)
  if array.length < 2
    return array
  end
  mid = array.length / 2
  left = merge_sort(array[0...mid])
  right = merge_sort(array[mid...array.length])
  merge(left, right)
end

def merge(left, right)
  return left if right[0].nil?
  return right if left[0].nil?
  if left[0] < right[0]
    left[0,1] + merge(left[1..-1], right)
  else
    right[0,1] + merge(left, right[1..-1])
  end
end


a = [6, 4, 3, 7, 4, 78, 234, 56, 32, 5678, 23, 657, 8, 2, 1, 34, 6, 0, -5, 6]

p merge_sort(a)
