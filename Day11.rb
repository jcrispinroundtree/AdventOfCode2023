input = File.read('Day11-input.txt')
lines = input.each_line.map { |line| line.chomp.split('') }

columns = lines.transpose
columns_to_duplicate = []
columns.each_with_index do |column, index|
  columns_to_duplicate << index unless column.include?('#')
end
columns_to_duplicate.reverse.each do |index|
  columns.insert(index, columns[index].clone)
end

new_lines = columns.transpose
rows_to_duplicate = []
new_lines.each_with_index do |row, index|
  rows_to_duplicate << index unless row.include?('#')
end
rows_to_duplicate.reverse.each do |index|
  new_lines.insert(index, new_lines[index].clone)
end

galaxy_coordinates = []
new_lines.each_with_index do |row, row_index|
  row.each_with_index do |char, col_index|
    galaxy_coordinates << [col_index, row_index] if char == '#'
  end
end

sum = 0
while galaxy_coordinates.length > 1 do
  g1 = galaxy_coordinates[0]
  galaxy_coordinates.each do |g2|
    sum += (g2[0]-g1[0]).abs + (g2[1]-g1[1]).abs
  end
  galaxy_coordinates.shift
end

puts "Part 1: " + sum.to_s
    

columns = lines.transpose
total_rows = lines.length + lines.count { |row| !row.include?('#') } * 999999
total_columns = columns.length + columns.count { |col| !col.include?('#') } * 999999

galaxy_coordinates = []
lines.each_with_index do |row, row_index|
  row_offset = row_index + row_index.downto(0).count { |i| !lines[i].include?('#') } * 999999
  row.each_with_index do |char, col_index|
    col_offset = col_index + col_index.downto(0).count { |i| !columns[i].include?('#') } * 999999
    galaxy_coordinates << [col_offset, row_offset] if char == '#'
  end
end

sum2 = 0
while galaxy_coordinates.length > 1 do
  g1 = galaxy_coordinates[0]
  galaxy_coordinates[1..].each do |g2|
    sum2 += (g2[0] - g1[0]).abs + (g2[1] - g1[1]).abs
  end
  galaxy_coordinates.shift
end

puts "Part 2: " + sum2.to_s