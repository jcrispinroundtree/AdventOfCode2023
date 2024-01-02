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


# make empty array
# for each item in input separated by a , 
#   run hash algorithm on item to determine which box it is talking about

#   if item contains = and the first characters found in the item before the = is not in the array, 
#     add item to the array replacing the = with a blank space,
#   otherwise if the first characters found in the item before the = is in the array 
#     then update the value after the whitespace that is in the array to be the value after the whitespace

#  if item contains - then find the item containing the characters found before the - and delete that item from the array
