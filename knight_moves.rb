class Node
  include Comparable
  attr_accessor :value, :children, :parent
  def initialize(
      value = nil, 
      parent = nil, 
      children = []
    )
    @value = value
    @parent = parent
    @children = children
  end

  def all_parents
    parents = []
    current = @parent
    while !current.nil?
      parents << current.value
      current = current.parent
    end
    return parents
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
      .select{ |a, b|  a <= 7 && b <= 7 && a >= 0 && b >= 0}
      .select{ |v| !all_parents.include?(v) }
  end
end

class NaryTree
  attr_accessor :root, :target
  def initialize(start, target)
    @root = NaryTree.build_tree(start, target)
    @target = target
  end

  def self.build_tree(start, target)
    root = Node.new(start, nil)
    nodes = [root]
    while !nodes.empty?
      current = nodes.shift
      moves = current.get_moves
      moves.each do |move|
        node = Node.new(move, current)
        current.children << node
        nodes << node
        if move == target
          return root
        end
      end
    end
    return root
  end

  def find(value, node = @root)
    queue = [node]
    until queue.empty?
      current = queue.shift
      return current if current.value == value
      current.children.each do |child|
        queue << child
      end
    end
  end

end

def knight_moves(start, target)
  moves = NaryTree.new(start, target)
  node = moves.find(target)
  sequence = node.all_parents.reverse
  puts "You made it in #{sequence.length} moves! Heres your path:"
  sequence.each {|move| p move}
  p target
end

knight_moves([3,3],[7,0])
