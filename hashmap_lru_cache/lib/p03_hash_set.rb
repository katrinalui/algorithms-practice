require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    unless include?(key.hash)
      self[key] << key.hash
      @count += 1
    end
    true
  end

  def include?(key)
    self[key].include?(key.hash)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key.hash)
      @count -= 1
    end
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }

    old_store.flatten.each { |el| insert(el) }
  end
end
