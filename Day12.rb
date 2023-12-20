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


# PART 2
total2 = 0

def unfold_record_and_checksum(record, checksum)
  unfolded_record = (record + '?') * 5
  unfolded_record.chop! 
  unfolded_checksum = (checksum + ',') * 5
  unfolded_checksum.chop!  
  return unfolded_record, unfolded_checksum.split(',').map(&:to_i)
end

File.open("Day12-input.txt").each do |row|
  record, checksum_str = row.split
  unfolded_record, unfolded_checksum = unfold_record_and_checksum(record, checksum_str)
  positions = {0 => 1}
  unfolded_checksum.each_with_index do |contiguous, i|
    new_positions = {}
    positions.each do |k, v|
      (k...(unfolded_record.length - unfolded_checksum[i + 1..-1].sum + unfolded_checksum[i + 1..-1].length)).each do |n|
        if n + contiguous - 1 < unfolded_record.length && !unfolded_record[n...n + contiguous].include?(".")
          if (i == unfolded_checksum.length - 1 && !unfolded_record[n + contiguous..-1].include?("#")) ||
             (i < unfolded_checksum.length - 1 && n + contiguous < unfolded_record.length && unfolded_record[n + contiguous] != "#")
            new_positions[n + contiguous + 1] = new_positions.fetch(n + contiguous + 1, 0) + v
          end
        end
        break if unfolded_record[n] == "#"
      end
    end
    positions = new_positions
  end
  total2 += positions.values.sum
end

puts total2