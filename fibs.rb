def fibs(n)
  result = []
  a = 0
  b = 1
  n.times do
    result << b
    a, b = b, a + b
  end
  result
end

def fibs_rec(n, array = [1, 1])
  return array if n <= 2
  array << array[-1] + array[-2]
  fibs_rec(n-1, array)
end

p fibs_rec(60)