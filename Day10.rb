input = File.readlines('Day10-input.txt')
height, width = input.length, input[0].length
matrix = Array.new(height) { Array.new(width) }
input.each_with_index do |line, i|
  line.each_char.with_index do |char, j|
    matrix[i][j] = char.to_s
  end
end

height.times do |y|
  width.times do |x|
    if matrix[y][x] == ("S")
      puts "Found S at #{x+1}, #{y+1}"
      S_x = x
      S_y = y
      break
    end
  end
end

x = S_x
y = S_y

puts matrix[y][x]

north = matrix[y-1][x]
south = matrix[y+1][x]
west = matrix[y][x-1]
east = matrix[y][x+1]

count = 0

def pathfinder_N(matrix, x, y, count)
  north = matrix[y-1][x]
  if matrix[y][x] != "S"
    case north 
    when "|" 
      y -= 1
      count += 1
      pathfinder_N(matrix, x, y, count)
    when "F" 
      y -= 1
      x += 1
      count += 2
      pathfinder_E(matrix, x, y, count)
    when "7" 
      y -= 1
      x -= 1
      count += 2
      pathfinder_W(matrix, x, y, count)
    end
  end
  puts count
end

def pathfinder_S(matrix, x, y, count)
  south = matrix[y+1][x]
  if matrix[y][x] != "S"
    case south 
    when "|" 
      y += 1
      count += 1
      pathfinder_S(matrix, x, y, count)
    when "J" 
      y += 1
      x -= 1
      count += 2
      pathfinder_W(matrix, x, y, count)
    when "L" 
      y += 1
      x += 1
      count += 2 
      pathfinder_E(matrix, x, y, count)
    end
  end
  puts count
end

def pathfinder_W(matrix, x, y, count)
  west = matrix[y][x-1]
  if matrix[y][x] != "S"
    case west 
    when "-" 
      x -= 1
      count += 1
      pathfinder_W(matrix, x, y, count)
    when "L" 
      x -= 1
      y -= 1
      count += 2
      pathfinder_N(matrix, x, y, count)
    when "F" 
      x -= 1
      y += 1
      count += 2
      pathfinder_S(matrix, x, y, count)
    end
  end
  puts count
end

def pathfinder_E(matrix, x, y, count)
  east = matrix[y][x+1]
  if matrix[y][x] != "S"
    case east 
    when "-" 
      x += 1
      count += 1
      pathfinder_E(matrix, x, y, count)
    when "7" 
      x += 1
      y += 1
      count += 2
      pathfinder_S(matrix, x, y, count)
    when "J" 
      x += 1
      y -= 1
      count += 2
      pathfinder_N(matrix, x, y, count)
    end
  end
  puts count
end

if north == ("|") || north == ("F") || north == ("7")
  case north
  when "|"
    y -= 1
    count += 1 
    pathfinder_N(matrix, x, y, count)
  when "F"
    y -= 1
    x += 1
    count += 2
    pathfinder_E(matrix, x, y, count)
  when "7"
    y -= 1
    x -= 1
    count += 2
    pathfinder_W(matrix, x, y, count)
  end
end

if south == ("|") || south == ("J") || south == ("L")
  case south
  when "|"
    y += 1
    count += 1
    pathfinder_S(matrix, x, y, count)
  when "J" 
    y += 1
    x -= 1
    count += 2
    pathfinder_W(matrix, x, y, count)
  when "L" 
    y += 1
    x += 1
    count += 2
    pathfinder_E(matrix, x, y, count)
  end
end

if west == ("-") || west == ("L") || west == ("F")
  case west
  when "-" 
    x -= 1
    count += 1
    pathfinder_W(matrix, x, y, count)
  when "L" 
    x -= 1
    y -= 1
    count += 2
    pathfinder_N(matrix, x, y, count)
  when "F" 
    x -= 1
    y += 1
    count += 2 
    pathfinder_S(matrix, x, y, count)
  end
end

if east == ("-") || east == ("J") || east == ("7")
  case east
  when "-" 
    x += 1
    count += 1
    pathfinder_E(matrix, x, y, count)
  when "7" 
    x += 1
    y += 1
    count += 2
    pathfinder_S(matrix, x, y, count)
  when "J" 
    x += 1
    y -= 1
    count += 2
    pathfinder_N(matrix, x, y, count)
  end
end   

# Instructions = struct.new(:prev_direction, :current_pipe, :next_direction)


