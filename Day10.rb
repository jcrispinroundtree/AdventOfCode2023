input = File.readlines('Day10-input.txt')
height, width = input.length, input[0].length
matrix = Array.new(height) { Array.new(width) }
input.each_with_index do |line, i|
  line.each_char.with_index do |char, j|
    matrix[i][j] = char.to_s
  end
end

height.times do |x|
    width.times do |y|
        if matrix[x][y] == ("S")
            puts "Found S at #{x}, #{y}"
        end
    end
end


# puts input

# Instructions = struct.new(:prev_direction, :current_pipe, :next_direction)

# if "L" && S || "L" && W
# if "J" && N || "J" && W
# if "F" && E || "F" && N
# if "|" && N || "|" && S
# if "-" && E || "-" && W
# if "7" && S || "7" && W
# if "." 

