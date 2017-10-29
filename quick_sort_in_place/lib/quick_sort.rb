require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1

    pivot = array[0]
    left = []
    right = []

    array[1..-1].each do |el|
      if el < pivot
        left << el
      else
        right << el
      end
    end

    sort1(left) + [pivot] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length - start < 2

    pivot_idx = partition(array, start, length, &prc)

    sort2!(array, start, pivot_idx - start, &prc)
    sort2!(array, pivot_idx + 1, length - (pivot_idx - start + 1), &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    pivot = array[start]
    partition = start
    pointer_idx = start + 1

    while pointer_idx < start + length
      if prc.call(pivot, array[pointer_idx]) > 0
        array[pointer_idx], array[partition + 1] = array[partition + 1], array[pointer_idx]
        partition += 1
      end
      pointer_idx += 1
    end

    array[start], array[partition] = array[partition], array[start]
    partition
  end
end
