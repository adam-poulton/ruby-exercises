class Node
  include Comparable
  attr_accessor :value, :children
  def initialize(value = nil, parent = nil, children = [])
    @value = value
    @parent = parent
    @children = children
  end

  def <=>(node)
    @value = node.value
  end

  def leaf?
    @children.empty?
  end

  def all_parents
    parents = []
    current = @parent
    while !current.nil?
      parents << node.parent
      current = node.parent
    end
    return parents
  end

  def find_children(node, target)
    return if node.value == target
    children = Node.get_moves(node)
  end

  def get_moves
    moves = []
    i, j = @value
    moves << [i - 2, j - 1]
    moves << [i - 2, j + 1]
    moves << [i - 1, j - 2]
    moves << [i - 1, j + 2]
    moves << [i + 1, j - 2]
    moves << [i + 1, j + 2]
    moves << [i + 2, j - 1]
    moves << [i + 2, j + 1]
    moves
      .select{ |a, b|  a < 8 && b < 8 && a > 0 && b > 0}
      .select{ |v| !all_parents.include?(v) }
  end
end

class NaryTree
  attr_accessor :root, :target
  def initialize(root, target)
    @root = Node.new(root, nil, Node.find_children(root, target))
    @target = target
  end
end

def knight_moves(start, target)
  return
end

node = Node.new([4,3])
p node.get_moves