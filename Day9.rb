# PART 1
input = File.readlines('Day9-input.txt').map(&:chomp)
total = 0

def process_array(input)
    arrays = [input]
    last_array = input
    loop do
      new_array = last_array.each_cons(2).map { |a, b| b - a }
      break if new_array.uniq == [0]
      arrays << new_array
      last_array = new_array
    end
    arrays.map(&:last).sum
end

input.each do |line|
    line = line.split(' ').map(&:to_i)
    result = process_array(line)
    total += result
end

puts total