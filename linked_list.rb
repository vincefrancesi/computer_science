# Linked List
#
# Usage:
#
# ll = LinkedList.new
# ll.add('Test 1')
# ll.add('Test 2')
#
# => ll.log
# <Node 1234: value: "Test 1">
# <Node 1235: value: "Test 2">
#
# => ll.last
# <Node 1235: value: "Test 2">
#
# => ll.iterator { |node| puts node.value }
# Test 1
# Test 2

class LinkedList
  attr_accessor :first

  # Log the linked list
  # Outputs all the nodes in the linked list
  #
  # Returns nil
  def log
    iterator do |node|
      puts node.inspect
    end
    return nil
  end

  # Add a value to the linked list
  # value: Any type of Object
  #
  # Returns a new Node
  def add(value)
    new_node = Node.new(value)
    if last
      last.next = new_node
    else
      self.first = new_node
    end

    return new_node
  end

  # Last node in the linked list
  #
  # Returns a Node
  def last
    return iterator
  end

  # Iterate over the linked list
  # [block]: A block that recieves each Node in the linked list
  #
  # Returns the last Node in the list
  def iterator(&block)
    node = first

    while node
      if block
        block.yield(node)
      end

      if node.next
        node = node.next
      else
        break
      end
    end

    return node
  end

  class Node
    attr_accessor :value
    attr_accessor :next

    # Initialize the Node
    # value: Any Object
    def initialize(value)
      self.value = value
    end

    # Inspect the Node
    # Returns a String representation of the Node
    def inspect
      "<Node #{object_id}: value: #{value.inspect}>"
    end

  end
end
