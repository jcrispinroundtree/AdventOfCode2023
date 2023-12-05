input = File.readlines('Day3-input.txt').map(&:chomp)
# PART 1
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
                if matrix[ni][nj].match?(/\D/) && matrix[ni][nj] != '.'
                  symbol_found = true
                end
              end
            end
          end
        end
        if symbol_found == true
          total += number_str.to_i
        end
      end
    end
  end     
  total
end
puts counter(input)

# PART 2
def counter2(input)
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
      if matrix[i][j] == '*'
        numbers = find_numbers_around_star(matrix, i, j, height, width)
        if numbers.length == 2
          num1, num2 = numbers
          total += num1.to_i * num2.to_i
          puts "#{num1.to_i} times #{num2.to_i} is #{num1.to_i * num2.to_i}"
        end
      end
    end
  end     
  total
end

def find_numbers_around_star(matrix, i, j, height, width)
  numbers = []
  [-1, 0, 1].each do |x|
    [-1, 0, 1].each do |y|
      ni, nj = i + x, j + y
      if ni.between?(0, height - 1) && nj.between?(0, width - 1) && matrix[ni][nj].match?(/\d/)
        number = read_number(ni, nj, matrix, height, width)
        numbers.push(number) unless numbers.include?(number)
      end
    end
  end
  numbers
end

def read_number(i, j, matrix, height, width)
  number_str = matrix[i][j].to_s
  k = j - 1
  while k >= 0 && matrix[i][k].match?(/\d/)
    number_str = matrix[i][k].to_s + number_str
    k -= 1
  end
  k = j + 1
  while k < width && matrix[i][k].match?(/\d/)
    number_str += matrix[i][k].to_s
    k += 1
  end
  number_str
end

puts counter2(input)

