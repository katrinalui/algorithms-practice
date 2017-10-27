require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  result = []
  queue = []

  vertices.each do |vertex|
    queue << vertex if vertex.in_edges.empty?
  end

  while !queue.empty?
    current_vertex = queue.shift
    result << current_vertex

    while !current_vertex.out_edges.empty?
      edge = current_vertex.out_edges.first
      neighbor = edge.to_vertex

      edge.destroy!
      queue << neighbor if neighbor.in_edges.empty?
    end
  end

  result.length == vertices.length ? result : []
end
