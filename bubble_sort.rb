def bubble_sort(array)
  sorted = false
  iteration = 0
  len = array.length
  while !sorted
    sorted = true
    (len-iteration-1).times{ |i|
      if array[i] > array[i+1] 
        tmp = array[i+1]
        array[i+1] = array[i]
        array[i] = tmp
        sorted = false
      end
    }
    iteration += 1
  end
  return array
end

def bubble_sort_by(array)
  sorted = false
  iteration = 0
  len = array.length
  while !sorted
    sorted = true
    (len-iteration-1).times{ |i|
      if yield(array[i], array[i+1]) 
        tmp = array[i+1]
        array[i+1] = array[i]
        array[i] = tmp
        sorted = false
      end
    }
    iteration += 1
  end
  return array
end


puts "#bubble_sort"
p bubble_sort([3,2,1,6,5,8,7,98,1])
p bubble_sort([1])
p bubble_sort([2,1])
puts "#bubble_sort_by"
puts " last letter:"
p bubble_sort_by(["adam", "samuel", "poulton", "zebra"]) { |left, right| left[-1] > right[-1] }
puts " first letter:"
p bubble_sort_by(["adam", "samuel", "poulton", "zebra"]) { |left, right| left[0] > right[0] }
puts " length:"
p bubble_sort_by(["adam", "samuel", "poulton", "zebra"]) { |left, right| left.length > right.length }