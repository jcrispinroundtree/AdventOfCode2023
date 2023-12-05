input = File.readlines('Day4-input.txt').map(&:chomp)

# PART 1
total = 0
input.each do |line|
    temp_total = 0
    _, numbers = line.split(':', 2)
    left_numbers, right_numbers = numbers.split('|').map { |s| s.split.map(&:to_i) }
    left_numbers.each do |l_number|
        right_numbers.each do |r_number|
            if l_number == r_number
                if temp_total == 0
                    temp_total = 1
                else
                    temp_total *= 2
                end
            end
        end
    end
    total += temp_total
    
end
puts total