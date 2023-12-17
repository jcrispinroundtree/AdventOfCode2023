require 'matrix'

def find_start(matrix)
  height = matrix.length
  width = matrix[0].length
  start = nil
  direction = nil
  height.times do |y|
    width.times do |x|
      if matrix[y][x] == 'S'
        start = Vector[y, x]
          if %w[7 | F].include?(matrix[y - 1][x])
            direction = 'north'
          elsif %w[F - L].include?(matrix[y][x - 1])
            direction = 'west'
          elsif %w[J - 7].include?(matrix[y][x + 1])
            direction = 'east'
          elsif %w[L | J].include?(matrix[y + 1][x])
            direction = 'south'
          end
        break
      end
    end
    break if start
  end
  [start, direction]
end

def traverse(point, direction, matrix)
  case direction
  when 'north'
    point += Vector[-1, 0]
    case matrix[point[0]][point[1]]
    when '7'
      direction = 'west'
    when 'F'
      direction = 'east'
    end 
  when 'west'
    point += Vector[0, -1]
    case matrix[point[0]][point[1]]
    when 'L'
      direction = 'north'
    when 'F'
      direction = 'south'
    end
  when 'east'
    point += Vector[0, 1]
    case matrix[point[0]][point[1]]
    when 'J'
      direction = 'north'
    when '7'
      direction = 'south'
    end
  when 'south'
    point += Vector[1, 0]
    case matrix[point[0]][point[1]]
    when 'L'
      direction = 'east'
    when 'J'
      direction = 'west'
    end
  end
  [point, direction]
end

def main
  # input = File.readlines('Day10-input.txt')
  # start, direction = find_start(input)
  # point = start
  # loop_count = 0
  # loop do
  #   point, direction = traverse(point, direction, input)
  #   loop_count += 1
  #   break if point == start && loop_count > 1
  # end
  # puts "Loop size: #{loop_count / 2}"
  input = File.readlines('Day10-input.txt')
  ans_2 = part2(input)
  puts "Part 2 Answer: #{ans_2}"
  # puts input
end


def part2(input)
  start, direction = find_start(input)
  point = start

  (0..).each do |i|
    break i if point == start && i > 0
    point, next_direction = traverse(point, direction, input)
    if direction == "south" || next_direction == "north"
      input[point[0]][point[1]] = '!'
    else
      input[point[0]][point[1]] = '_'
    end
    direction = next_direction
  end

  input.sum do |line|
    subbed = line.gsub('_', '').gsub('!!', '')
    puts subbed
    inside = false
    inside_count = 0
    subbed.each_char do |c|
      if c == '!'
        inside = !inside
      elsif inside
        inside_count += 1
      end
    end
    # raise "#{line.inspect} -> #{subbed.inspect} stays inside" if inside
    inside_count
  end
end

main

