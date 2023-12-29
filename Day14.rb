# PART 1
input = File.read("Day14-input.txt")
grid = input.split("\n").map { |line| line.chars }

def move_north(grid, row, col)
  while row > 0
    row -= 1
    if ['O', '#'].include?(grid[row][col])
      return row + 1 
    end
  end
  0 
end

grid.each_with_index do |line, row|
  line.each_with_index do |char, col|
    if char == 'O'
      new_row = move_north(grid, row, col)
      if new_row != row
        grid[row][col] = '.'
        grid[new_row][col] = 'O'
      end
    end
  end
end

score = 0
grid_size = grid.size
grid.each_with_index do |line, row|
  line.each_with_index do |char, col|
    score += grid_size - row if char == 'O'
  end
end


puts "Score: #{score}"


# PART 2
map = []

height = 0
width = 0
target_number_of_spins = 1000000000

def process_input(map)
  input = File.read("Day14-input.txt").strip
  input.lines.each do |line|
    map.push(line.strip.split(''))
  end
  [map.length, map[0].length]
end

def spin(map, height, width)
  send_rocks_to_north(map, height, width)
  send_rocks_to_west(map, height, width)
  send_rocks_to_south(map, height, width)
  send_rocks_to_east(map, height, width)
end

def send_rocks_to_north(map, height, width)
  1.upto(height - 1) do |row|
    0.upto(width - 1) do |col|
      send_rock_to_north(map, row, col) if map[row][col] == 'O'
    end
  end
end

def send_rock_to_north(map, row, col)
  while row > 0
    break unless map[row - 1][col] == '.'
    map[row][col] = '.'
    map[row - 1][col] = 'O'
    row -= 1
  end
end

def send_rocks_to_south(map, height, width)
  (height - 2).downto(0) do |row|
    0.upto(width - 1) do |col|
      send_rock_to_south(map, row, col, height) if map[row][col] == 'O'
    end
  end
end

def send_rock_to_south(map, row, col, height)
  while row < height - 1
    break unless map[row + 1][col] == '.'
    map[row][col] = '.'
    map[row + 1][col] = 'O'
    row += 1
  end
end

def send_rocks_to_west(map, height, width)
  0.upto(height - 1) do |row|
    1.upto(width - 1) do |col|
      send_rock_to_west(map, row, col) if map[row][col] == 'O'
    end
  end
end

def send_rock_to_west(map, row, col)
  while col > 0
    break unless map[row][col - 1] == '.'
    map[row][col] = '.'
    map[row][col - 1] = 'O'
    col -= 1
  end
end

def send_rocks_to_east(map, height, width)
  0.upto(height - 1) do |row|
    (width - 2).downto(0) do |col|
      send_rock_to_east(map, row, col, width) if map[row][col] == 'O'
    end
  end
end

def send_rock_to_east(map, row, col, width)
  while col < width - 1
    break unless map[row][col + 1] == '.'
    map[row][col] = '.'
    map[row][col + 1] = 'O'
    col += 1
  end
end

def count_rocks(map, height)
  sum = 0
  0.upto(height - 1) do |n|
    factor = height - n
    sum += factor * count_rocks_row(map, n)
  end
  sum
end

def count_rocks_row(map, n)
  map[n].count('O')
end

def map_to_string(map)
  map.map { |line| line.join('') }.join(';')
end

# Main execution
map = []
height, width = process_input(map)

memory = []
counts = []

index_of_ancestor = -1
loop do
  spin(map, height, width)
  s = map_to_string(map)
  n = count_rocks(map, height)

  index_of_ancestor = memory.index(s)
  break unless index_of_ancestor.nil?

  memory.push(s)
  counts.push(n)
end

initial_spins = index_of_ancestor
spins_per_loop = memory.length - initial_spins
remaining_spins = (target_number_of_spins - initial_spins) % spins_per_loop
index = initial_spins + remaining_spins - 1

puts "The answer is #{counts[index]}"