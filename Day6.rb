input = File.readlines('Day6-input.txt').map(&:chomp)
time_data = input[0]
distance_data = input[1]
times = time_data.split.map(&:to_i)
distances = distance_data.split.map(&:to_i)
final_time_count = 0
4.times do |i|
    optimal_time_count = 0
    times[i+1].times do |j|
        time_held = j 
        winning_distance = time_held * (times[i+1] - time_held)
        if winning_distance > distances[i+1]
            optimal_time_count += 1 
        end
    end
    if final_time_count == 0
        final_time_count = optimal_time_count
    elsif optimal_time_count < final_time_count
        final_time_count *= optimal_time_count
    end
    puts final_time_count
end