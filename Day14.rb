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
input = File.read("Day14-input.txt")
grid = input.split("\n").map { |line| line.chars }

def deep_copy_grid(grid)
  grid.map(&:dup)
end

def move_rocks(grid, direction)
  moved = false
  new_grid = deep_copy_grid(grid)

  case direction
  when 0 # North
    moved = true while move_north(new_grid)
  when 1 # West
    moved = true while move_west(new_grid)
  when 2 # South
    moved = true while move_south(new_grid)
  when 3 # East
    moved = true while move_east(new_grid)
  end

  [new_grid, moved]
end

def move_north(grid)
  moved = false
  (1...grid.size).each do |row|
    (0...grid[row].size).each do |col|
      if grid[row][col] == 'O' && grid[row - 1][col] == '.'
        grid[row - 1][col], grid[row][col] = grid[row][col], '.'
        moved = true
      end
    end
  end
  moved
end

def move_west(grid)
  moved = false
  grid.each do |row|
    (1...row.size).each do |col|
      if row[col] == 'O' && row[col - 1] == '.'
        row[col - 1], row[col] = row[col], '.'
        moved = true
      end
    end
  end
  moved
end

def move_south(grid)
  moved = false
  (0...(grid.size - 1)).to_a.reverse.each do |row|
    (0...grid[row].size).each do |col|
      if grid[row][col] == 'O' && grid[row + 1][col] == '.'
        grid[row + 1][col], grid[row][col] = grid[row][col], '.'
        moved = true
      end
    end
  end
  moved
end

def move_east(grid)
  moved = false
  grid.each do |row|
    (0...(row.size - 1)).to_a.reverse.each do |col|
      if row[col] == 'O' && row[col + 1] == '.'
        row[col + 1], row[col] = row[col], '.'
        moved = true
      end
    end
  end
  moved
end

max_cycles_to_check = 1000  # Adjust this number based on your needs
previous_states = {}
cycle_detected = false
cycle_length = 0
cycles_checked = 0

while cycles_checked < max_cycles_to_check
  4.times do |i|  # Perform one full cycle (North, West, South, East)
    grid, moved = move_rocks(grid, i)
    break unless moved  # Stop if no rocks moved in a full cycle
  end

  state = grid.map(&:join).join("\n")
  if previous_states[state]
    cycle_detected = true
    cycle_length = cycles_checked - previous_states[state]
    break
  else
    previous_states[state] = cycles_checked
  end

  cycles_checked += 1
end

if cycle_detected
  puts "Cycle Detected: Yes, Length: #{cycle_length}"
  equivalent_cycles = 1_000_000_000 % cycle_length

  # Reset grid to original state and apply equivalent cycles
  grid = input.split("\n").map { |line| line.chars }
  equivalent_cycles.times do
    4.times do |i|
      grid, _ = move_rocks(grid, i)
    end
  end

  # Calculate the load on the north support beams
  load = 0
  grid_size = grid.size
  grid.each_with_index do |line, row|
    line.each_with_index do |char, col|
      load += grid_size - row if char == 'O'
    end
  end

  puts "Load on the north support beams after 1,000,000,000 cycles: #{load}"
else
  puts "Cycle Detected: No"
end