# Linked List Example
class LinkedList
  attr_accessor :first

  def log
    iterator do |node|
      puts node.inspect
    end
    return nil
  end

  def add(value)
    new_node = Node.new(value)
    if last
      last.next = new_node
    else
      self.first = new_node
    end

    return new_node
  end

  def last
    return iterator
  end

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

    def initialize(value)
      self.value = value
    end

    def inspect
      "<Node #{object_id}: value: #{value.inspect}>"
    end
  end
end
