def find_reflected_rows(grid, smudges = 0)
  return 0 if grid.any? { |row| row.nil? || row.empty? }
  (1...grid.size).each do |r|
    above = grid[0...r].reverse
    below = grid[r..]
    diffs = above.zip(below).sum do |x, y|
      next 0 if x.nil? || y.nil?
      x.zip(y).count { |a, b| a != b }
    end
    return r if diffs == smudges
  end
  0
end

def transpose(grid)
  grid[0].zip(*grid[1..])
end

def solve(grids, smudges = 0)
  solution = 0
  grids.each do |grid|
    block = grid.split("\n").map { |line| line.chars }
    solution += find_reflected_rows(block, smudges) * 100
    transposed_block = transpose(block)
    solution += find_reflected_rows(transposed_block, smudges)
  end
  solution
end

input = File.read("Day13-input.txt")
grids = input.strip.split("\n\n")

solution1 = solve(grids)
solution2 = solve(grids, 1)

puts "Solution 1: #{solution1}"
puts "Solution 2: #{solution2}"
