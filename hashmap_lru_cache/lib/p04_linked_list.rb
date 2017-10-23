class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @prev.next = @next if @prev
    @next.prev = @prev if @next
    @next = nil
    @prev = nil
    self
  end
end

class LinkedList
  include Enumerable

  def initialize
    @first = Node.new
    @last = Node.new
    @first.next = @last
    @last.prev = @first
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @first.next
  end

  def last
    @last.prev
  end

  def empty?
    first.next.nil? && last.prev.nil?
  end

  def get(key)
    node = select { |n| n.key == key }.first
    node.nil? ? nil : node.val
  end

  def include?(key)
    any? { |node| node.key == key }
  end

  def append(key, val)
    new_node = Node.new(key, val)
    previous = @last.prev
    @last.prev = new_node
    previous.next = new_node
    new_node.next = @last
    new_node.prev = previous
    new_node
  end

  def update(key, val)
    each { |node| node.val = val if node.key == key }
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.remove
        return node.val
      end
    end
    nil
  end

  def each
    node_to_check = first
    until node_to_check == @last
      yield node_to_check
      node_to_check = node_to_check.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
