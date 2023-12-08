# PART 1
input = File.readlines('Day5-input.txt').map(&:chomp)
seeds = input.shift.split.map(&:to_i)
seeds.shift
seed = []
seed_range = []
seeds.length().times do |i|
  if i.even? == true 
    seed << seeds[i]
  else
    seed_range << seeds[i]
  end
end
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

# Part 2
def parse_input
  categories = {}
  current_category = nil
  seeds = []
  File.readlines('Day5-input.txt', chomp: true).each do |line|
    if line.start_with?("seeds:")
      seed_info = line.split(':')[1].scan(/\d+/).map(&:to_i)
      seeds = []
      seed_info.each_slice(2) { |start, len| seeds << Range.new(start, start + len - 1) }
    elsif line.end_with?("map:")
      current_category = line.split(' ')[0].gsub('-', '_').to_sym
      categories[current_category] = []
    else
      dest, source, count = line.scan(/\d+/).map(&:to_i)
      categories[current_category] << { range: source..(source + count - 1), dest: dest } if dest
    end
  end
  [seeds, categories]
end
def map_category(map, seed)
  new_seeds = []
  map.each do |h|
    range = h[:range]
    dest = h[:dest]
    offset = dest - range.begin
    if seed.end < range.begin || seed.begin > range.end       
      next
    end
    if seed.begin >= range.begin && seed.end <= range.end  
      new_seeds << Range.new(seed.begin+offset, seed.end+offset)
      break
    end
    if seed.begin < range.begin && seed.end > range.end  
      new_seeds << map_category(map, Range.new(seed.begin, range.begin-1))
      new_seeds << Range.new(range.begin+offset, range.end+offset)
      new_seeds << map_category(map, Range.new(range.end+1, seed.end))
      break
    end
    if seed.begin <= range.begin && seed.end <= range.end   
      new_seeds << Range.new(range.begin+offset, seed.end+offset)
      new_seeds << map_category(map, Range.new(seed.begin, range.begin-1)) if seed.begin < range.begin
      break
    end
    if seed.begin >= range.begin && seed.end >= range.end 
      new_seeds << Range.new(seed.begin+offset, range.end+offset)
      new_seeds << map_category(map, Range.new(range.end+1, seed.end)) if seed.end > range.end
      break
    end
  end
  new_seeds = [seed] unless new_seeds.size > 0
  new_seeds.flatten
end
def find_lowest_location_number(seeds, maps)
  categories = [:seed_to_soil, :soil_to_fertilizer, :fertilizer_to_water, :water_to_light, :light_to_temperature, :temperature_to_humidity, :humidity_to_location]
  categories.each do |category|
    next_seeds = []
    seeds.each do |seed|
      new_seeds = map_category(maps[category], seed)
      next_seeds << new_seeds
    end
    seeds = next_seeds.flatten
  end
  seeds.map(&:begin).min
end
seeds, maps = parse_input
lowest_location = find_lowest_location_number(seeds, maps)
puts "The Lowest location number is: #{lowest_location}"