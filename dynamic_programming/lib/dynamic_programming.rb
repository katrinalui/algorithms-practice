class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = {
      1 => [[1]], 2 => [[1, 1], [2]], 3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }
  end

  def blair_nums(n)
    return @blair_cache[n] unless @blair_cache[n].nil?

    num = blair_nums(n - 1) + blair_nums(n - 2) + ((n - 1) * 2 - 1)
    @blair_cache[n] = num

    num
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    cache = {
      1 => [[1]], 2 => [[1, 1], [2]], 3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }
    return cache if n < 4

    (4..n).each do |i|
      cache[i] = []
      1.upto(3) do |j|
        cache[i] += cache[i - j].map { |array| [j] + array }
      end
    end

    cache
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
    @frog_cache[n]
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]
    @frog_cache[n] = frog_hops_top_down_helper(n - 1).map { |el| [1] + el } + frog_hops_top_down_helper(n - 2).map { |el| [2] + el } + frog_hops_top_down_helper(n - 3).map { |el| [3] + el }
    @frog_cache[n]
  end

  def super_frog_hops(n, k)
    cache = super_frog_cache_builder(n, k)
    cache[n]
  end

  def super_frog_cache_builder(n, k)
    cache = { 0 => [[]], 1 => [[1]] }
    return cache if n < 2

    (2..n).each do |i|
      cache[i] = []
      (1..k).each do |j|
        break unless i > j
        cache[i] += cache[i - j].map { |array| [j] + array }
      end
      cache[i] += [[i]] if i <= k
    end

    cache
  end

  def knapsack(weights, values, capacity)
    table = knapsack_table(weights, values, capacity)
    table.last.last
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    n = weights.length
    table = Array.new(capacity + 1) { Array.new(n, 0) }

    1.upto(capacity) do |c|
      (0...n).each do |i|
        if weights[i] > c
          table[c][i] = table[c][i - 1]
        elsif i == 0
          table[c][i] = values[i]
        else
          prev_val = table[c][i - 1]
          table[c][i] = [prev_val, table[c - weights[i]][i - 1] + values[i]].max
        end
      end
    end

    table
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
