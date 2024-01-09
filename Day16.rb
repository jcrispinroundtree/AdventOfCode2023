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
puts "Energised Matrix:"
puts energized_count