# PART 1
input = File.readlines('Day5-input.txt').map(&:chomp)
seeds = input.shift.split.map(&:to_i)
input_text = input.join("\n")
maps = input_text.split(/\n(?=\w+-to-\w+ map:)/)
maps_hash = {}
maps.each do |map|
  next if map.empty?
  map_name, *data = map.split("\n")
  next if map_name.nil? || !map_name.include?(' map:')
  map_name = map_name.gsub(' map:', '').split('-to-').join('_to_')
  maps_hash[map_name] = []
  data.each do |line|
    next if line.include?('map:')
    destination_start, source_start, range_length = line.split.map(&:to_i)
    maps_hash[map_name] << { range: (source_start...(source_start + range_length)), offset: destination_start - source_start }
  end
end

def process_seed(seed, maps_hash)
  categories = %w[seed soil fertilizer water light temperature humidity location]
  categories.each_cons(2) do |source, destination|
    map_key = "#{source}_to_#{destination}"
    range_data = maps_hash[map_key].find { |data| data[:range].include?(seed) }
    if range_data
      seed = seed + range_data[:offset]
    end
  end
  seed
end

lowest_location = seeds.map { |seed| process_seed(seed, maps_hash) }.min
puts "The lowest location number is: #{lowest_location}"