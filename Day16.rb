# convert the input into a matrix

# light starts in the top left corner moving right moving one step each time

# if encountering . continue

# if encountering | and moving up continue
# if encountering | and moving down continue
# if encountering | and moving left next move is up and down (both happen)
# if encountering | and moving right next move is up and down (both happen)

# if encountering - and moving up next move is left and right (both happen)
# if encountering - and moving down next move is left and right (both happen)
# if encountering - and moving left continue
# if encountering - and moving right continue

# if encountering \ and moving up next move is left
# if encountering \ and moving down next move is right
# if encountering \ and moving left next move is up
# if encountering \ and moving right next move is down
 
# if encountering / and moving up next move is right
# if encountering / and moving down next move is left
# if encountering / and moving left next move is down
# if encountering / and moving right next move is up

# mark cell in energise_count matrix as energised if not already marked as energised
# when finished propagating light through the matrix, count the number of energised cells in the energise_count matrix

def simulate_light(matrix, x, y, direction, energise_count)
  return if x < 0 || x >= matrix[0].size || y < 0 || y >= matrix.size || energise_count[y][x]

  energise_count[y][x] = true
  directions = [[1, 0], [0, -1], [-1, 0], [0, 1]] # right, up, left, down

  case matrix[y][x]
  when '|'
    if [0, 2].include?(direction) # moving right or left
      simulate_light(matrix, x, y + 1, 1, energise_count) # move down
      simulate_light(matrix, x, y - 1, 3, energise_count) # move up
      return
    end
  when '-'
    if [1, 3].include?(direction) # moving up or down
      simulate_light(matrix, x + 1, y, 0, energise_count) # move right
      simulate_light(matrix, x - 1, y, 2, energise_count) # move left
      return
    end
  when '\\'
    direction = case direction
                when 0 then 3 # right to down
                when 1 then 2 # up to left
                when 2 then 1 # left to up
                when 3 then 0 # down to right
                end
  when '/'
    direction = case direction
                when 0 then 1 # right to up
                when 1 then 0 # up to right
                when 2 then 3 # left to down
                when 3 then 2 # down to left
                end
  end

  new_x, new_y = x + directions[direction][0], y + directions[direction][1]
  simulate_light(matrix, new_x, new_y, direction, energise_count)
end

def start_simulation(matrix)
  energise_count = Array.new(matrix.size) { Array.new(matrix[0].size, false) }
  simulate_light(matrix, 0, 0, 0, energise_count) # Start position and direction (right)
  
  # Display the energised matrix
  energise_count.each do |row|
    row.each do |cell|
      print cell ? '*' : ' '
    end
    puts
  end

  # Count energised cells
  energise_count.flatten.count(true)
end

# Read the input file and convert it into a matrix
input = File.read("Day16-input.txt")
matrix = input.split("\n").map { |line| line.chars }

puts "Energised Matrix:"
puts start_simulation(matrix)