require_relative "heap"

class Array
  def heap_sort!
    (2..length).each do |count|
      BinaryMinHeap.heapify_up(self, count - 1, count)
    end

    length.downto(2).each do |count|
      self[0], self[count - 1] = self[count - 1], self[0]
      BinaryMinHeap.heapify_down(self, 0, count - 1)
    end

    self.reverse!
  end
end
