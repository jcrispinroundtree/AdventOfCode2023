input = File.readlines('Day3-input.txt').map(&:chomp)
def counter(input)
  height, width = input.length, input[0].length
  matrix = Array.new(height) { Array.new(width) }
  input.each_with_index do |line, i|
    line.each_char.with_index do |char, j|
      matrix[i][j] = char
    end
  end
  total = 0
  height.times do |i|
    width.times do |j|
      if matrix[i][j].match?(/\d/) && matrix[i][j-1].match?(/\D/)
        symbol_found = false
        number_str = matrix[i][j].to_s
        k = j + 1
        while k < width && matrix[i][k].match?(/\d/)
          number_str += matrix[i][k].to_s
          k += 1
        end
        (j...k).each do |digit_index|
          [-1, 0, 1].each do |x|
            [-1, 0, 1].each do |y|
              ni, nj = i + x, digit_index + y
              if ni.between?(0, height - 1) && nj.between?(0, width - 1)
                if ['$', '%', '&', '#', '@', '!', '?', '+', '=', '*', '^', '~', '|', '/', '\\', '-', '_', '<', '>', ':', ';', ',', '(', ')', '[', ']', '{', '}'].include?(matrix[ni][nj])
                  symbol_found = true
                end
              end
            end
          end
        end
        if symbol_found == true
          puts number_str
          total += number_str.to_i
        end
      end
    end
  end     
  total
end
puts counter(input)