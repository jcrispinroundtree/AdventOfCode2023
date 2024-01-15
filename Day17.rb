# A* pathfinding algorithm, in the directions north south east and west find the lowest number and move in that direction, 
# however you cannot travel in the same direction for more than 3 blocks, 
# at this point it needs to move in a different direction
# each cell has a number, which is the weight of the square. 
# lower numbers imply shorter path.

require 'set'

# Reading input from a file
input = File.readlines("day17-input.txt").map { |line| line.chomp.split('').map(&:to_i) }
rows = input.length
columns = input[0].length

# Creating the graph
graph = {}
$result = Float::INFINITY
$final_path = []

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

def walk(neighbor, heat, graph, rows, columns, path)
  return if heat >= [graph[neighbor][:heat], $result].min

  if neighbor.split("l")[1] == "(#{columns - 1},#{rows - 1})"
    $result = heat
    $final_path.replace(path + [neighbor.split(/[()]/)[1].split(',').map(&:to_i)])  # Storing the final path
    return
  end

  graph[neighbor][:heat] = heat
  graph[neighbor][:neighbors].each do |key, value|
    walk(key, heat + value, graph, rows, columns, path + [neighbor.split(/[()]/)[1].split(',').map(&:to_i)])
  end
end

starting_neighbors.each do |neighbor, heat|
  walk(neighbor, heat, graph, rows, columns, [])
end

# Creating a matrix for the path
matrix = Array.new(rows) { Array.new(columns, '.') }  # '.' represents unvisited cells

# Marking the start and end points
matrix[0][0] = 'S'  # Marking the start
matrix[rows - 1][columns - 1] = 'G'  # Marking the end

# Marking the path in the matrix
$final_path.each do |y, x|  # Ensure that the coordinates are used correctly
  matrix[y][x] = '*' unless [y, x] == [0, 0] || [y, x] == [rows - 1, columns - 1]
end

# Printing the matrix
matrix.each { |row| puts row.join(' ') }