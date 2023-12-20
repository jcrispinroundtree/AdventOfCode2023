# PART 1
total = 0
File.open("Day12-input.txt").each do |row|
  record, checksum_str = row.split
  checksum = checksum_str.split(",").map(&:to_i)
  positions = {0 => 1}
  checksum.each_with_index do |contiguous, i|
    new_positions = {}
    positions.each do |k, v|
      (k...(record.length - checksum[i + 1..-1].sum + checksum[i + 1..-1].length)).each do |n|
        if n + contiguous - 1 < record.length && !record[n...n + contiguous].include?(".")
          if (i == checksum.length - 1 && !record[n + contiguous..-1].include?("#")) ||
             (i < checksum.length - 1 && n + contiguous < record.length && record[n + contiguous] != "#")
            new_positions[n + contiguous + 1] = new_positions.fetch(n + contiguous + 1, 0) + v
          end
        end
        break if record[n] == "#"
      end
    end
    positions = new_positions
  end
  total += positions.values.sum
end

puts total


