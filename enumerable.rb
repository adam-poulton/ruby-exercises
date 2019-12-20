module Enumerable

  def my_each
    for item in self
      yield(item)
    end
    self
  end

  def my_each_with_index
    for i in 0...self.length
      yield(self[i], i)
    end
    self
  end

  def my_select
    result = []
    self.my_each{ |item| result << item if yield(item) }
    result
  end
  
  def my_all?
    result = true
    self.my_each{ |item| result = false if !yield(item) }
    result
  end

  def my_any?
    self.my_each { |item| return true if yield(item)}
    false
  end

  def my_none?
    self.my_each {|item| return false if yield(item)}
    true
  end

  def my_count
    result = 0
    self.my_each {|item| result += 1 if yield(item)}
    result
  end

  def my_map
    result = []
    self.my_each {|item| result.push(yield(item))}
    result
  end

  def my_inject(acc)
    self.my_each {|item| acc = yield(acc, item)}
    acc
  end

end
a = ["adam", "samuel", "poulton"]

puts a.my_all? {|i| i=="adam"} == false
puts a.my_all? {|i| i.is_a? String} == true
puts a.my_any? {|i| i.is_a? String} == true
puts a.my_any? {|i| i=="bob"} == false
puts a.my_any? {|i| i=="poulton"} == true
puts a.my_count {|i| i=="adam"} == 1
puts a.my_count {|i| i.length > 4} == 2
puts a.my_count {|i| i=="bob"} == 0
puts a.map {|i| i.length} == [4, 6, 7]
puts a.my_inject(0) {|sum, item| sum + item.length} == 17
