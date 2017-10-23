class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    each_with_index.reduce(0) do |accumulator, (el, i)|
      (el.hash + i.hash) ^ accumulator
    end
  end
end

class String
  def hash
    hash = chars.map(&:ord)
    hash.join("").to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.sort_by(&:hash).hash
  end
end
