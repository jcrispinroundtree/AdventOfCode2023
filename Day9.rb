# PART 1
input = File.readlines('Day9-input.txt').map(&:chomp)
total = 0

def find_next(input)
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
    total += find_next(line)
end

puts total

# PART 2
histories = []
total2 = 0

File.open("Day9-input.txt") do |file|
    file.each_line do |line|
        histories << line.split.map(&:to_i)
    end
end

histories.each do |history|
    descents = [history]
    while true
        next_level = descents.last.each_cons(2).map { |a, b| b - a }
        break if next_level.all? { |x| x == 0 }
        descents << next_level
    end
    diff = 0
    descents.reverse_each do |descent|
        diff = descent.first - diff
    end
    total2 += diff
end

puts total2