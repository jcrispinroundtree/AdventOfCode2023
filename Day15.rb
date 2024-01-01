input = File.read("Day15-input.txt")
total = 0
input.split(',').each do |item|
  current_value = 0
  item.each_char do |char|
    ascii_code = char.ord
    current_value += ascii_code
    current_value *= 17
    current_value %= 256
  end
  total += current_value
end

puts "Total: #{total}"