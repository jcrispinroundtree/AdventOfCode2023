input = File.readlines('Day8-input.txt').map(&:chomp)
instructions = input.shift.split.to_s.tr('[]', '').tr('"', '')

input.shift
total = 0
step_arr = []

Steps = Struct.new(:value, :left, :right)
input.each do |line|
    matches = line.match(/(\w+) = \((\w+), (\w+)\)/)
    step = Steps.new(matches[1], matches[2], matches[3])
    step_arr << step
end

step_arr.each do |step|
    if step.value == "AAA"
        while step.value != "ZZZ"
            instructions.each_char do |char|
                case char
                when "L" then next_step = step.left 
                when "R" then next_step = step.right
                end
                step = step_arr.find { |s| s.value == next_step }
                total += 1
                if step.value == "ZZZ"
                    break
                end
            end
        end
    end
end
puts total

