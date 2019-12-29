class LinkedList
  attr_reader :head, :tail, :size
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(node)
    @size += 1
    if @head.nil?
      @head = node
      @tail = node
    else
      @tail.next_node = node
      @tail = node
      @tail.next_node = nil
    end
  end

  def prepend(node)
    @size += 1
    node.next_node = @head
    if @head.nil?
      @head = node
      @tail = node
    else
      @head = node
    end
  end

  def at(index)
    count = 0
    current = @head
    while count < index && !current.nil?
      current = current.next_node
      count += 1
    end
    current
  end

  def pop
    if @head.nil?
      return
    elsif @head.next_node.nil?
      @head = nil
      @tail = nil
    else
      @tail = self.at(@size - 2)
      @tail.next_node = nil
    end
    @size -= 1
  end

  def shift
    if @head.nil?
      return
    elsif @head.next_node.nil?
      @head = nil
      @tail = nil
    else
      @head = @head.next_node
    end
    size -= 1
  end

  def contains?(value)
    index = head
    while !index.nil?
      if index.value == value
        return true
      end
      index = index.next_node
    end
    return false
  end

  def find(data)
    index = head
    count = 0
    while !index.nil?
      if index.value == data
        return count
      end
      count += 1
      index = index.next_node
    end
    return nil
  end

  def to_s
    result = ""
    index = head
    while !index.nil?
      result += "( #{index.value} ) -> "
      index = index.next_node
    end
    return result += "nil"
  end

  def insert_at(node, index)
    if index >= @size
      self.append(node)
    elsif index == 0
      self.prepend(node)
    else
      parent = self.at(index - 1)
      node.next_node = parent.next_node
      parent.next_node = node
      @size += 1
    end
  end

  def remove_at(index)
    if index >= (@size - 1)
      self.pop
    elsif index == 0
      self.shift
    else
      node = self.at(index)
      parent = self.at(index - 1)
      parent.next_node = node.next_node
      @size -= 1
    end
  end
end

class Node
  attr_accessor :value, :next_node
  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

list = LinkedList.new
10.times do |i|
  list.append(Node.new(i))
end
puts list
# list.insert_at(Node.new("Adam"), 3)
# puts list
# list.remove_at(4)
# puts list
# a_list = LinkedList.new
# a_list.insert_at(Node.new("Adam"), 0)
# puts a_list
# a_list.remove_at(0)
