# Part 1
require 'set'

input = File.readlines("Day17-input.txt").map { |line| line.chomp.split('').map(&:to_i) }
rows = input.length
columns = input[0].length

graph = {}
$result = Float::INFINITY

(0...rows).each do |y|
  (0...columns).each do |x|
    vertical_key = "vertical(#{x},#{y})"
    horizontal_key = "horizontal(#{x},#{y})"
    
    graph[vertical_key] = { heat: Float::INFINITY, neighbors: {} }
    graph[horizontal_key] = { heat: Float::INFINITY, neighbors: {} }

    (1..3).each do |i|
      if y + i >= 0 && y + i < rows
        graph[vertical_key][:neighbors]["horizontal(#{x},#{y + i})"] = (1..i).sum { |j| input[y + j][x] }
      end
      if y - i >= 0 && y - i < rows
        graph[vertical_key][:neighbors]["horizontal(#{x},#{y - i})"] = (1..i).sum { |j| input[y - j][x] }
      end
      if x + i >= 0 && x + i < columns
        graph[horizontal_key][:neighbors]["vertical(#{x + i},#{y})"] = (1..i).sum { |j| input[y][x + j] }
      end
      if x - i >= 0 && x - i < columns
        graph[horizontal_key][:neighbors]["vertical(#{x - i},#{y})"] = (1..i).sum { |j| input[y][x - j] }
      end
    end
  end
end

starting_neighbors = graph["horizontal(0,0)"][:neighbors].merge(graph["vertical(0,0)"][:neighbors])

def walk(neighbor, heat, graph, rows, columns)
  return if heat >= [graph[neighbor][:heat], $result].min

  if neighbor.split("l")[1] == "(#{columns - 1},#{rows - 1})"
    $result = heat
    return
  end

  graph[neighbor][:heat] = heat
  graph[neighbor][:neighbors].each do |key, value|
    walk(key, heat + value, graph, rows, columns)
  end
end

starting_neighbors.each do |neighbor, heat|
  walk(neighbor, heat, graph, rows, columns)
end

puts $result
# Part 2