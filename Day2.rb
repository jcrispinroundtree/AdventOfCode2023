input = File.readlines('Day2-input.txt').map(&:chomp)
# PART 1
total = 0
input.each do |game|
    game_valid = true
    game_name, game_data = game.split(': ', 2) 
    gameid = game_name[/\d+/].to_i
    game_sections = game.split(';').map(&:strip)
    game_sections.each do |section|
        red_count = section.scan(/(\d+) red/).flatten.map(&:to_i).sum
        green_count = section.scan(/(\d+) green/).flatten.map(&:to_i).sum
        blue_count = section.scan(/(\d+) blue/).flatten.map(&:to_i).sum
        if red_count > 12 || green_count > 13 || blue_count > 14
            game_valid = false
            break
        end
    end
    total += gameid if game_valid
end
puts total
# PART 2
total2 = 0
input.each do |game|
    game_name, game_data = game.split(': ', 2) 
    game_sections = game.split(';').map(&:strip)
    red_max = 0
    green_max = 0
    blue_max = 0
    game_sections.each do |section|
        red_count = section.scan(/(\d+) red/).flatten.map(&:to_i).sum
        green_count = section.scan(/(\d+) green/).flatten.map(&:to_i).sum
        blue_count = section.scan(/(\d+) blue/).flatten.map(&:to_i).sum
        if red_max < red_count
            red_max = red_count
        end
        if green_max < green_count
            green_max = green_count
        end
        if blue_max < blue_count
            blue_max = blue_count
        end
    end
    colour_power = red_max * green_max * blue_max
    total2 += colour_power
end
puts total2