class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |n, m| n <=> m }
  end

  def count
    @store.count
  end

  def extract
    extracted = store[0]

    if count > 1
      @store[0] = @store.pop
      BinaryMinHeap.heapify_down(@store, 0, &prc)
    else
      @store.pop
    end

    extracted
  end

  def peek
    store[0]
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, count - 1, @prc)
  end

  public
  def self.child_indices(len, parent_index)
    child_indices = []
    [1, 2].each do |el|
      index = 2 * parent_index + el
      child_indices << index if index < len
    end

    child_indices
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |n, m| n <=> m }

    parent = array[parent_idx]
    child_indices = child_indices(len, parent_idx)

    if child_indices.all? { |i| prc.call(parent, array[i]) <= 0 }
      return array
    end

    # swap_idx = nil
    sorted_child_indices = child_indices.sort { |a, b| prc.call(array[a], array[b]) }
    swap_idx = sorted_child_indices[0]

    array[parent_idx], array[swap_idx] = array[swap_idx], parent
    heapify_down(array, swap_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |n, m| n <=> m }

    return array if child_idx == 0

    parent_idx = parent_index(child_idx)

    if prc.call(array[child_idx], array[parent_idx]) >= 0
      return array
    else
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      heapify_up(array, parent_idx, len, &prc)
    end
  end
end
