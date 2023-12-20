input = File.read("Day13-input.txt")
grids = input.split(/\n\n+/)

def process_grid(ys, xs)
  ys = ys.map { |y| y.to_i(2) }
  xs = xs.map { |x| x.to_i(2) }
  { top: find_mirror(ys), left: find_mirror(xs), ys:, xs: }
end

def find_mirror(lines)
  mirror_line = 0
  counts = {}
  lines.each_with_index do |line, index|
    next unless index + 1 < lines.count && line == lines[index + 1]
    left = lines[0..index].reverse
    right = lines[(index + 1)..(lines.count - 1)]
    small, big = [left, right].sort_by(&:count)
    mirror = small.each_with_index.all? { |s, i| s == big[i] }
    counts[small.count] = (index + 1) if mirror
  end
  counts[counts.keys.max] || 0
end

def process_line(line, xs, y_index)
  x = []
  line.chars.each_with_index do |char, x_index|
    bit = char == '#' ? '1' : '0'
    x << bit
    xs[x_index] = xs[x_index] ? xs[x_index] + bit : bit
  end
  [x, xs]
end

def output_results(data)
  total = 0
  data.each do |key, val|
    grid = val[:ys].map { |num| num.to_s(2).rjust(val[:xs].max.to_s(2).length, '0') }
    next if grid.empty?
    height = grid.length
    width = grid.first.length
    mark_mirrors_on_grid!(grid, val)
    total += val[:left] + (100 * val[:top])
  end
  total
end

def mark_mirrors_on_grid!(grid, val)
  if val[:left].positive?
    grid.map! { |y| y.ljust(val[:left], '0') }  # Ensure each row has enough length
    grid.each { |y| y.insert(val[:left], '|') }
  end
  if val[:top].positive?
    grid.insert(val[:top], Array.new(grid.first.length, '-')) if grid.length > val[:top]
  end
end

data = {}
grids.each_with_index do |grid, id|
  ys = []
  xs = []
  y_index = 0
  grid.split("\n").each do |line|
    x, xs = process_line(line, xs, y_index)
    ys[y_index] = x.join
    y_index += 1
  end
  data[id] = process_grid(ys, xs)
end

puts output_results(data)