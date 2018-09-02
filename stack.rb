# Stack
#
# Usage:
#
# s = Stack.new
# => s.empty?
# true
# => s.push('Test 1')
# <Node 1234: value="Test 1">
# => s.push('Test 2')
# <Node 1235: value="Test 2">
# => s.count
# 2
# => s.each { |node| puts node.value }
# Test 1
# Test 2
# => s.pop
# <Node 1235: value="Test 2">
# => s.top
# <Node 1234: value="Test 1">
class Stack
  attr_accessor :top

  # Push a value onto the stack
  # value: Any Object
  #
  # Returns a new Node
  def push(value)
    node = Node.new(value)
    node.previous = top
    self.top = node

    return node
  end

  # Pop a value off the top of the stack
  #
  # Returns the Node at the top of the stack
  def pop
    return nil if empty?

    node = top
    self.top = node.previous

    return node
  end

  # Is the Stack empty?
  #
  # Returns a Boolean
  def empty?
    return top.nil?
  end

  # Count the number of nodes in the Stack
  #
  # Returns an Integer
  def count
    count = 0

    each do |node|
      count += 1
    end

    return count
  end

  # Loop over each Node in the stack
  # block: Block
  #
  # Returns the first node in the Stack
  def each(&block)
    node = top

    while node
      if block
        block.yield(node)
      end

      if node.previous
        node = node.previous
      else
        break
      end
    end

    return node
  end

  class Node
    attr_accessor :value
    attr_accessor :previous

    # Initialize a new Node
    # value: Any Object
    def initialize(value)
      self.value = value
    end

    def inspect
      "<Node #{object_id}: value=#{value.inspect}>"
    end
  end
end
