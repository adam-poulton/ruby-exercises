class Node
  include Comparable
  attr_accessor :value, :left, :right
  def initialize(value = nil)
    @value = value
    @left = nil
    @right = nil
  end

  def <=>(node)
    @value <=> node.value
  end

  def leaf?
    @left.nil? && @right.nil?
  end

  def single_parent?
    @left.nil? != @right.nil? 
  end

  def double_parent?
    @left && @right
  end
end

class Tree
  attr_accessor :root
  def initialize(array)
    @root = Tree.build_tree(array.uniq.sort)
  end

  def insert(value, node = @root)
    if @root.nil?
      @root = Node.new(value)
    elsif value < node.value
      if node.left.nil?
        node.left = Node.new(value)
      else
        self.insert(value, node.left)
      end
    elsif value > node.value
      if node.right.nil?
        node.right = Node.new(value)
      else
        self.insert(value, node.right)
      end
    end
  end

  def delete(value, node = @root)
    if node.nil?
      return node
    elsif value < node.value
      node.left = delete(value, node.left)
    elsif value > node.value
      node.right = delete(value, node.right)
    elsif value == node.value
      if node.leaf?
        return nil
      elsif node.single_parent?
        return node.left || node.right
      end
      temp = min_node(node.right)
      node.value = temp.value
      node.right = delete(temp.value, node.right)
      
    end
    node
  end

  def find(value, node = @root)
    if node.nil?
      return node
    elsif value < node.value
      find(value, node.left)
    elsif value > node.value
      find(value, node.right)
    elsif value == node.value
      return node
    end
  end

  private
  
  def self.build_tree(array, start = 0, ending = array.length)
    return if (start > ending)
    mid = start + ((ending - start) / 2)
    return if array[mid].nil?
    node = Node.new(array[mid])
    node.left = build_tree(array, start, mid - 1)
    node.right = build_tree(array, mid + 1, ending)
    return node
  end

  def min_node(node = @root)
    current = node
    until current.left.nil?
      current = current.left
    end
    current
  end

  def max_node(node = @root)
    current = node
    until current.right.nil?
      current = current.right
    end
    current
  end
end


a = [1,2,3,4,5,6,7,8,9]
tree = Tree.new(a)
p tree
tree.insert(20)
p tree
tree.insert(6)
p tree
p tree.find(9)
tree.delete(5)
p tree