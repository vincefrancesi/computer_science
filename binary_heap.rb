# Binary Heap - Example of a max-heap
#
# Usage:
# Set initial value
# => bh = BinaryHeap.new(50)
#
# Insert a value into the tree
# => bh.insert(10)
#
# Get the height of the tree
# => bh.height
# 1
#
# Get all the nodes of the tree
# => bh.nodes
# [<BinaryHeap value=10 height=0>, <BinaryHeap value=50 height=1>]
#
class BinaryHeap
  attr_accessor :value, :left_child, :right_child

  # Initialize the BinaryHeap
  # value: Integer of initial value
  def initialize(value)
    @value = value
  end

  # Insert a value into the tree
  #
  # Returns nil
  def insert(insert_value)
    if left_child.nil?
      self.left_child = BinaryHeap.new(insert_value)
    elsif right_child.nil?
      self.right_child = BinaryHeap.new(insert_value)
    else
      left_count = left_nodes.count
      right_count = right_nodes.count
      lh = left_height
      rh = right_height

      if left_count == right_count
        left_child.insert(insert_value)
      elsif left_count == (right_count * 2 + 1)
        right_child.insert(insert_value)
      elsif lh == rh
        right_child.insert(insert_value)
      else
        left_child.insert(insert_value)
      end
    end

    if left_child && should_swap?(left_child.value)
      swap_values(left_child)
    end
    if right_child && should_swap?(right_child.value)
      swap_values(right_child)
    end
    nil
  end

  # Height of the node in the tree
  #
  # Returns an Integer
  def height
    heights = [left_height, right_height].sort

    heights.last
  end

  # All the nodes in the tree sorted
  #
  # Returns an Array of BinaryHeaps
  def nodes
    left_nodes + [self] + right_nodes
  end

  # Inspect
  #
  # Returns a String representation of the BinaryHeap
  def inspect
    "<#{self.class.to_s} value=#{value.inspect} height=#{height.inspect}>"
  end

  private

  def swap_values(binary_heap)
    current_value = value
    self.value = binary_heap.value
    binary_heap.value = current_value
  end

  def should_swap?(new_value)
    new_value > value
  end

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
