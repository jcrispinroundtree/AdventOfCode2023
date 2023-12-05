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
  number_str1 = ''
  number_str2 = ''
  foundnum1 = false
  foundnum2 = false
  height.times do |i|
    width.times do |j|
      if matrix[i][j] == '*'
        [-1, 0, 1].each do |x|
          [-1, 0, 1].each do |y|
            ni, nj = i + x, j + y
            if ni.between?(0, height - 1) && nj.between?(0, width - 1)
              if matrix[ni][nj].match?(/\d/) && foundnum1 == false && foundnum2 == false
                if x == -1  && matrix[ni+1][nj].match(/\D/) || x == 0 && matrix[ni+1][nj].match(/\D/)
                  number_str1 = readnum1(ni, nj, matrix, height, width)
                  puts "number 1 is " + number_str1
                  foundnum1 = true
                  break
                end
                if x == 0 && matrix[ni+1][nj].match(/\D/)
                  number_str1 = readnum1(ni, nj, matrix, height, width)
                  puts "number 1 is " + number_str1
                  foundnum1 = true
                  break
                end
                if x == 1 && matrix[ni-1][nj].match(/\D/)
                  number_str1 = readnum1(ni, nj, matrix, height, width)
                  puts "number 1 is " + number_str1
                  foundnum1 = true
                  break
                end
              end
              if matrix[ni][nj].match?(/\d/) && foundnum1 == true && foundnum2 == false
                if x == -1  && matrix[ni+1][nj].match(/\D/)
                  number_str2 = readnum2(ni, nj, matrix, height, width)
                  puts "number 2 is " + number_str2
                  foundnum2 = true
                  break
                end
                if x == 0 && matrix[ni+1][nj].match(/\D/)
                  number_str2 = readnum2(ni, nj, matrix, height, width)
                  puts "number 2 is " + number_str2
                  foundnum2 = true
                  break
                end
                if x == 1 && matrix[ni-1][nj].match(/\D/)
                  number_str2 = readnum2(ni, nj, matrix, height, width)
                  puts "number 2 is " + number_str2
                  foundnum2 = true
                  break
                end
              end
            end
          end
        end
        if foundnum1 == true && foundnum2 == true
          total += number_str1.to_i * number_str2.to_i
          puts "#{number_str1.to_i} times #{number_str2.to_i} is #{number_str1.to_i * number_str2.to_i}"
        end
        foundnum1 = false
        foundnum2 = false
      end
    end
  end     
  total
end

def readnum1( i, j, matrix, height, width)
  ni, nj = i, j
  c = 0
  while matrix[ni][nj-c].match?(/\d/)
    c += 1
  end
  if matrix[ni][nj-c].match?(/\D/)
    c -= 1
    number_str1 = matrix[ni][nj-c].to_s
    k = (nj - c) + 1
    while k < width && matrix[ni][k].match?(/\d/)
      number_str1 += matrix[ni][k].to_s
      k += 1
    end
  end
  return number_str1
end

def readnum2( i, j, matrix, height, width)
  ni, nj = i, j
  c = 0
  while matrix[ni][nj-c].match?(/\d/)
    c += 1
  end
  if matrix[ni][nj-c].match?(/\D/)
    c -= 1
    number_str2 = matrix[ni][nj-c].to_s
    k = (nj - c) + 1
    while k < width && matrix[ni][k].match?(/\d/)
      number_str2 += matrix[ni][k].to_s
      k += 1
    end
  end
  return number_str2
end



puts counter2(input)

