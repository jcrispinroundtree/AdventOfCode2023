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
  (1...grid.length).to_a.reverse.each do |row|
    (0...grid[row].length).each do |col|
      next unless grid[row][col] == 'O'
      new_row = row - 1
      while new_row >= 0 && grid[new_row][col] == '.'
        new_row -= 1
      end
      next if new_row == row - 1
      grid[row][col], grid[new_row + 1][col] = '.', 'O'
    end
  end
  grid
end

def tilt_west(grid)
  grid.each do |row|
    (1...row.length).to_a.reverse.each do |col|
      next unless row[col] == 'O'
      new_col = col - 1
      while new_col >= 0 && row[new_col] == '.'
        new_col -= 1
      end
      next if new_col == col - 1
      row[col], row[new_col + 1] = '.', 'O'
    end
  end
  grid
end

def tilt_south(grid)
  (0...(grid.length - 1)).each do |row|
    (0...grid[row].length).each do |col|
      next unless grid[row][col] == 'O'
      new_row = row + 1
      while new_row < grid.length && grid[new_row][col] == '.'
        new_row += 1
      end
      next if new_row == row + 1
      grid[row][col], grid[new_row - 1][col] = '.', 'O'
    end
  end
  grid
end

def tilt_east(grid)
  grid.each do |row|
    (0...(row.length - 1)).each do |col|
      next unless row[col] == 'O'
      new_col = col + 1
      while new_col < row.length && row[new_col] == '.'
        new_col += 1
      end
      next if new_col == col + 1
      row[col], row[new_col - 1] = '.', 'O'
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