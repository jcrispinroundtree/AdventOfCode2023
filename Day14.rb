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
  File.read(file_path).split("\n").map(&:chars)
end

def tilt_grid(grid, direction)
  case direction
  when :north
    tilt_north(grid)
  when :west
    tilt_west(grid)
  when :south
    tilt_south(grid)
  when :east
    tilt_east(grid)
  else
    grid
  end
end
def tilt_north(grid)
  moved = false
  (1...grid.length).each do |row|
    (0...grid[row].length).each do |col|
      if grid[row][col] == 'O' && grid[row - 1][col] == '.'
        grid[row][col], grid[row - 1][col] = '.', 'O'
        moved = true
      end
    end
  end
  grid  # Return the updated grid
end

def tilt_west(grid)
  moved = false
  grid.each do |row|
    (1...row.length).each do |col|
      if row[col] == 'O' && row[col - 1] == '.'
        row[col], row[col - 1] = '.', 'O'
        moved = true
      end
    end
  end
  grid  # Return the updated grid
end

def tilt_south(grid)
  moved = false
  (0...(grid.length - 1)).to_a.reverse.each do |row|
    (0...grid[row].length).each do |col|
      if grid[row][col] == 'O' && grid[row + 1][col] == '.'
        grid[row][col], grid[row + 1][col] = '.', 'O'
        moved = true
      end
    end
  end
  grid  # Return the updated grid
end

def tilt_east(grid)
  moved = false
  grid.each do |row|
    (0...(row.length - 1)).to_a.reverse.each do |col|
      if row[col] == 'O' && row[col + 1] == '.'
        row[col], row[col + 1] = '.', 'O'
        moved = true
      end
    end
  end
  grid  # Return the updated grid
end
def one_cycle(grid)
  [:north, :west, :south, :east].each do |direction|
    grid = tilt_grid(grid, direction)
    # Optional: Add logging here to check the grid state after each tilt
  end
  grid
end

def calculate_load(grid)
  load = 0
  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      load += 1 if cell == 'O'
    end
  end
  load
end

def find_cycle(grid, max_cycles)
  seen = {}
  cycles_checked = 0

  while cycles_checked < max_cycles
    grid = one_cycle(grid)
    # Optional: Add logging here to check the grid state after each full cycle

    grid_state = grid.map(&:join).join(":")
    if seen[grid_state]
      return [true, cycles_checked - seen[grid_state]]
    end

    seen[grid_state] = cycles_checked
    cycles_checked += 1
  end

  [false, 0]
end

# Main execution logic for Part 2
input_file = "Day14-input.txt"
grid = read_input(input_file)
max_cycles_to_check = 1000
cycle_detected, cycle_length = find_cycle(grid, max_cycles_to_check)

if cycle_detected
  equivalent_cycles = 1_000_000_000 % cycle_length
  equivalent_cycles.times { grid = one_cycle(grid) }
  final_load = calculate_load(grid)
  puts "Load after 1,000,000,000 cycles: #{final_load}"
else
  puts "No cycle detected within #{max_cycles_to_check} cycles."
end