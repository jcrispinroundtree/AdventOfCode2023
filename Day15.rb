# PART 1
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

# PART 2
def hash_algorithm(str)
  current_value = 0
  str.each_char do |char|
    current_value += char.ord
    current_value *= 17
    current_value %= 256
  end
  current_value
end

boxes = Array.new(256) { [] }

input = File.read("Day15-input.txt")
input.split(',').each do |item|
  hash_value = hash_algorithm(item.gsub(/[-=].*/, '')) 

  if item.include?('=')
    key, value = item.split('=')
    existing_item = boxes[hash_value].find { |i| i.start_with?("#{key} ") }
    if existing_item
      existing_item.sub!(/\d+$/, value)
    else
      boxes[hash_value] << "#{key} #{value}"
    end
  elsif item.include?('-')
    key = item.split('-').first
    boxes[hash_value].reject! { |i| i.start_with?("#{key} ") }
  end
end

total = 0

boxes.each_with_index do |box, index|
  box.each_with_index do |item, slot|
    key, value = item.split
    total += (index+1) * (slot+1) * value.to_i
    puts "#{slot+1} #{index} #{key} #{value} = #{(index+1) * (slot+1) * value.to_i}"
  end
end

puts "Boxes: #{boxes.inspect}"
puts total