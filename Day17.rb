# A* pathfinding algorithm, in the directions north south east and west find the lowest number and move in that direction, 
# however you cannot travel in the same direction for more than 3 blocks, 
# at this point it needs to move in a different direction
# each cell has a number, which is the weight of the square. 
# lower numbers imply shorter path.

require 'set'

class Node
  attr_accessor :x, :y, :cost, :parent, :direction, :direction_count

  def initialize(x, y, cost, parent = nil, direction = nil, direction_count = 0)
    @x = x
    @y = y
    @cost = cost.to_i
    @parent = parent
    @direction = direction
    @direction_count = direction_count
  end

  def ==(other)
    x == other.x && y == other.y
  end

  def eql?(other)
    self == other
  end

  def hash
    [x, y].hash
  end
end


def parse_input(file)
  grid = []
  File.readlines(file).each do |line|
    grid << line.chomp.chars.map(&:to_i)
  end
  grid
end

def heuristic(node, goal)
  (node.x - goal.x).abs + (node.y - goal.y).abs
end

def neighbors(node, grid)
    directions = [[0, 1, 'E'], [1, 0, 'S'], [-1, 0, 'N'], [0, -1, 'W']]
    
    directions.map do |dx, dy, dir|
      new_x, new_y = node.x + dx, node.y + dy
      if new_x.between?(0, grid.length - 1) && new_y.between?(0, grid[0].length - 1)
        new_direction_count = node.direction == dir ? node.direction_count + 1 : 1
        if new_direction_count <= 3
          Node.new(new_x, new_y, grid[new_x][new_y], node, dir, new_direction_count)
        end
      end
    end.compact
end

def a_star(start, goal, grid)
  open_set = Set.new
  open_set.add(start)
  came_from = {}
  g_score = Hash.new(Float::INFINITY)
  g_score[start] = 0
  f_score = Hash.new(Float::INFINITY)
  f_score[start] = heuristic(start, goal)

  until open_set.empty?
    current = open_set.min_by { |node| f_score[node] }

    return reconstruct_path(came_from, current) if current == goal

    open_set.delete(current)
    neighbors(current, grid).each do |neighbor|
      next if current.direction == neighbor.direction && current.direction_count >= 3

      tentative_g_score = g_score[current] + neighbor.cost.to_i
      if tentative_g_score < g_score[neighbor]
        came_from[neighbor] = current
        g_score[neighbor] = tentative_g_score
        f_score[neighbor] = tentative_g_score + heuristic(neighbor, goal)
        open_set.add(neighbor) unless open_set.include?(neighbor)
      end
    end
  end

  return nil
end

def reconstruct_path(came_from, current)
  total_path = [current]
  while came_from.include?(current)
    current = came_from[current]
    total_path.prepend(current)
  end
  total_path
end

def mark_path_on_grid(grid, path)
    # Create a display grid with the same dimensions as the original grid
    display_grid = Array.new(grid.length) { Array.new(grid[0].length) }
  
    # Fill the display grid with the original grid's values
    grid.each_with_index do |row, x|
      row.each_with_index do |cost, y|
        display_grid[x][y] = cost.to_s
      end
    end
  
    # Mark the path on the display grid
    path.each do |node|
      display_grid[node.x][node.y] = '*' unless node == path.first || node == path.last
    end
  
    # Mark the start and goal positions
    display_grid[path.first.x][path.first.y] = 'S'
    display_grid[path.last.x][path.last.y] = 'G'
  
    display_grid
end
  
def print_grid(grid)
    grid.each do |row|
      puts row.join(' ')
    end
end

def calculate_total_cost(path)
  path.sum(&:cost)
end

grid = parse_input("Day17-input.txt")
start = Node.new(0, 0, grid[0][0], nil, nil, 0)
goal = Node.new(grid.length - 1, grid[0].length - 1, grid[-1][-1], nil, nil, 0)

path = a_star(start, goal, grid)

if path
  display_grid = mark_path_on_grid(grid, path)
  puts "Path found:"
  print_grid(display_grid)
  total_cost = calculate_total_cost(path)
  puts "Total cost of the path: #{total_cost}"
else
  puts "No path found"
end