input = File.readlines('input.txt').map(&:chomp)
total = 0
digit_map = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
digit_map_reversed = digit_map.map(&:reverse)
input.each do |line|
  positions = (1..9).map { |i| [line.index(i.to_s), i.to_s] } + digit_map.each_with_index.map { |number_string, i| [line.index(number_string), (i + 1).to_s] }
  first_digit = positions.reject { |position| position[0].nil? }.min_by(&:first)[1]
  positions = (1..9).map { |i| [line.reverse.index(i.to_s), i.to_s] } + digit_map_reversed.each_with_index.map { |number_string, i| [line.reverse.index(number_string), (i + 1).to_s] }
  last_digit = positions.reject { |position| position[0].nil? }.min_by(&:first)[1]
  total += (first_digit + last_digit).to_i
end
puts total