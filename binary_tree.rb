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
    @root = Tree.build_tree(array)
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

  def level_order(node = @root, results = [], &block)
    queue = [node]
    until queue.empty?
      current = queue.shift
      block_given? ? yield(current) : results << current.value
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
    end
    results unless block_given?
  end

  def level_order_rec(node = @root, queue = [], result = [], &block)
    return if node.nil?
    block_given? ? yield(node) : result << node.value
    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?
    level_order_rec(queue.shift, queue, result, &block)
    result unless block_given?
  end

  def inorder(node = @root, result = [], &block)
    return if node.nil?
    inorder(node.left, result, &block)
    block_given? ? yield(node) : result << node.value
    inorder(node.right, result, &block)
    result unless block_given?
  end

  def preorder(node = @root, result = [], &block)
    return if node.nil?
    block_given? ? yield(node) : result << node.value
    preorder(node.left, result, &block)
    preorder(node.right, result, &block)
    result unless block_given?
  end

  def postorder(node = @root, result = [], &block)
    return if node.nil?
    postorder(node.left, result, &block)
    postorder(node.right, result, &block)
    block_given? ? yield(node) : result << node.value
    result unless block_given?
  end

  def depth(node = @root)
    return 0 if node.nil?
    left_depth = depth(node.left)
    right_depth = depth(node.right)
    return left_depth + 1 unless right_depth > left_depth
    return right_depth + 1
  end

  def balanced?(node = @root)
    return true if node.nil?
    left_depth = depth(node.left)
    right_depth = depth(node.right)
    return (left_depth - right_depth).abs <= 1
  end

  def rebalance!(node = @root)
    @root = Tree.build_tree(level_order)
  end

  private
  
  def self.build_tree(array, start = 0, ending = array.length)
    array = array.uniq.sort
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
