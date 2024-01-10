# Part 1

optics = File.readlines("Day16-input.txt").map(&:strip)
energized = Array.new(optics.size) { Array.new(optics[0].size) { [false, false, false, false] } }
physics = {
    0 => {'dx' => 0, 'dy' => -1, '/' => [2], '\\' => [1], '-' => [1, 2]},
    1 => {'dx' => -1, 'dy' => 0, '/' => [3], '\\' => [0], '|' => [0, 3]},
    2 => {'dx' => 1, 'dy' => 0, '/' => [0], '\\' => [3], '|' => [0, 3]},
    3 => {'dx' => 0, 'dy' => 1, '/' => [1], '\\' => [2], '-' => [1, 2]}
}
photons = [[-1, 0, 2]]

until photons.empty?
    photon = photons.pop
    photon[0] += physics[photon[2]]['dx']
    photon[1] += physics[photon[2]]['dy']

    if photon[0].between?(0, optics[0].size - 1) && photon[1].between?(0, optics.size - 1)
        char = optics[photon[1]][photon[0]]
        new_directions = physics[photon[2]].key?(char) ? physics[photon[2]][char] : [photon[2]]
        new_directions.each do |new_d|
            unless energized[photon[1]][photon[0]][new_d]
                photons.push([photon[0], photon[1], new_d])
                energized[photon[1]][photon[0]][new_d] = true
            end
        end
    end
end

energized_count = energized.flatten(1).count { |cell| cell.any? }
puts "Energised Array:"
puts energized_count

# for displaying energised array
# energized.each do |row|
#   row_display = row.map { |cell| cell.any? ? '*' : ' ' }.join
#   puts row_display
# end

# Part 2

optics = File.readlines("Day16-input.txt").map(&:strip)
physics = [
  {'dx' => 0, 'dy' => -1, '/' => [2], '\\' => [1], '-' => [1, 2]},
  {'dx' => -1, 'dy' => 0, '/' => [3], '\\' => [0], '|' => [0, 3]},
  {'dx' => 1, 'dy' => 0, '/' => [0], '\\' => [3], '|' => [0, 3]},
  {'dx' => 0, 'dy' => 1, '/' => [1], '\\' => [2], '-' => [1, 2]}
]
max_energized = 0

4.times do |direction|
  optics.length.times do |i|
    x = direction == 2 ? -1 : direction == 1 ? optics.length : 0
    y = direction == 3 ? -1 : direction == 0 ? optics.length : 0
    x, y = i, y if [0, 3].include?(direction)
    x, y = x, i if [1, 2].include?(direction)
    photons = [[x, y, direction]]
    energized = Array.new(optics.size) { Array.new(optics[0].size) { [false, false, false, false] } }

    until photons.empty?
      photon = photons.pop
      photon[0], photon[1] = photon[0] + physics[photon[2]]['dx'], photon[1] + physics[photon[2]]['dy']

      if photon[0].between?(0, optics[0].size - 1) && photon[1].between?(0, optics.size - 1)
        char = optics[photon[1]][photon[0]]
        new_directions = physics[photon[2]].key?(char) ? physics[photon[2]][char] : [photon[2]]
        new_directions.each do |new_d|
          unless energized[photon[1]][photon[0]][new_d]
            photons.push([photon[0], photon[1], new_d])
            energized[photon[1]][photon[0]][new_d] = true
          end
        end
      end
    end

    count = energized.flatten(1).count { |cell| cell.any? }
    max_energized = [max_energized, count].max
  end
end

puts max_energized