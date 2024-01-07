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

def simulate_light(matrix)
    directions = [[1, 0], [0, -1], [-1, 0], [0, 1]] # right, up, left, down
    energise_count = Array.new(matrix.size) { Array.new(matrix[0].size, false) }
    puts matrix.size
    puts matrix[0].size
    x, y = 0, 0
    direction = 0 # Start moving right
  
    while x >= 0 && x < matrix[0].size && y >= 0 && y < matrix.size
      energise_count[y][x] = true
  
      case matrix[y][x]
      when '|'
        direction = [1, 3].include?(direction) ? direction : [1, 3] # Up or down if moving left or right
      when '-'
        direction = [0, 2].include?(direction) ? direction : [0, 2] # Left or right if moving up or down
      when '\\'
        direction = (direction + 3) % 4 # Rotate left
      when '/'
        direction = (direction + 1) % 4 # Rotate right
      end
  
      # Update position based on direction
      x += directions[direction][0]
      y += directions[direction][1]
    end
  
    # Count energised cells
    energise_count.flatten.count(true)
  end
  
  # Read the input file and convert it into a matrix
  input = File.read("Day16-input.txt")
  matrix = input.split("\n").map { |line| line.chars }
  
  puts simulate_light(matrix)
 

