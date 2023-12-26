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
def read_input(file_path)
  File.readlines(file_path).map(&:chomp).map(&:chars)
end

def tilt_north(grid)
  (1...grid.length).each do |row|
    (0...grid[row].length).each do |col|
      if grid[row][col] == 'O' && grid[row - 1][col] == '.'
        grid[row][col], grid[row - 1][col] = '.', 'O'
      end
    end
  end
  grid
end

def tilt_west(grid)
  grid.each do |row|
    (1...row.length).each do |col|
      if row[col] == 'O' && row[col - 1] == '.'
        row[col], row[col - 1] = '.', 'O'
      end
    end
  end
  grid
end

def tilt_south(grid)
  (0...(grid.length - 1)).to_a.reverse.each do |row|
    (0...grid[row].length).each do |col|
      if grid[row][col] == 'O' && grid[row + 1][col] == '.'
        grid[row][col], grid[row + 1][col] = '.', 'O'
      end
    end
  end
  grid
end

def tilt_east(grid)
  grid.each do |row|
    (0...(row.length - 1)).to_a.reverse.each do |col|
      if row[col] == 'O' && row[col + 1] == '.'
        row[col], row[col + 1] = '.', 'O'
      end
    end
  end
  grid
end

def one_cycle(grid)
  grid = tilt_north(grid)
  grid = tilt_west(grid)
  grid = tilt_south(grid)
  grid = tilt_east(grid)
  grid
end

def print_grid(grid)
  grid.each { |row| puts row.join }
  puts "\n"
end

def simulate_and_print_cycles(grid, num_cycles)
  (1..num_cycles).each do |cycle|
    grid = one_cycle(grid)
    puts "After #{cycle} cycles:"
    print_grid(grid)
  end
end

# Main Execution
input_file = "Day14-input.txt"
grid = read_input(input_file)

simulate_and_print_cycles(grid, 300)