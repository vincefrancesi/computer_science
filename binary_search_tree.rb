# Binary Search Tree
#
# Usage:
#
# => bst = BinarySearchTree.new(500)
# Seed some test values
# => 1000.times { bst.insert(rand(10000)) }
# Determine the height of the tree
# => bst.height
# 22
# What is the root value
# => bst.value
# 500
# Search for a node in the tree
# => bst.search(234)
# <BinarySearchTree value=234 height=3>
# Insert a new value
# => bst.insert(133)
# <BinarySearchTree value=133 height=0>
# Get all the nodes in the tree in order
# => bst.nodes
# [<BinarySearchTree value=22 height=0>, <BinarySearchTree value=24 height=1>, ...]
#
class BinarySearchTree
  attr :value
  attr_accessor :left_child, :right_child

  # Initialize BinarySearchTree with value
  def initialize(value)
    @value = value
  end

  # Search for a value in the tree
  #
  # Returns a BinarySearchTree or nil
  def search(search_value)
    if search_value == value
      return self
    elsif !left_child.nil? && value > search_value
      return left_child.search(search_value)
    elsif !right_child.nil? && value < search_value
      return right_child.search(search_value)
    else
      return nil
    end
  end

  # Insert a value into the tree
  #
  # Returns a BinarySearchTree
  def insert(insert_value)
    if insert_value == value
      return self
    elsif value > insert_value
      if left_child.nil?
        self.left_child = self.class.new(insert_value)
        return left_child
      else
        return self.left_child.insert(insert_value)
      end
    elsif value < insert_value
      if right_child.nil?
        self.right_child = self.class.new(insert_value)
        return right_child
      else
        return self.right_child.insert(insert_value)
      end
    end
  end

  # Height of the Tree
  #
  # Returns an Integer
  def height
    heights = [left_height, right_height].sort

    heights.last
  end

  # All the nodes in the tree sorted
  #
  # Returns an Array of BinarySearchTrees
  def nodes
    left_nodes + [self] + right_nodes
  end

  # Inspect
  #
  # Returns a String representation of the BinarySearchTree
  def inspect
    "<#{self.class.to_s} value=#{value.inspect} height=#{height.inspect}>"
  end

  private

  def left_height
    return 0 if left_child.nil?

    return left_child.height + 1
  end

  def right_height
    return 0 if right_child.nil?

    return right_child.height + 1
  end

  def left_nodes
    if left_child
      left_child.nodes
    else
      []
    end
  end

  def right_nodes
    if right_child
      right_child.nodes
    else
      []
    end
  end

end
