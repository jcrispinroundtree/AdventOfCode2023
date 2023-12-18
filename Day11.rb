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

new_text = new_lines.map { |line| line.join }.join("\n")
puts new_text
