# PART 1
input = File.readlines('Day4-input.txt').map(&:chomp)
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

# PART 2
Card = Struct.new(:card_id, :matches)
cards = []
total2 = 0
input.each do |line|
  card_id = line.match(/Card\s+(\d+):/)[1].to_i
  matches = 0
  _, numbers = line.split(':', 2)
  left_numbers, right_numbers = numbers.split('|').map { |s| s.split.map(&:to_i) }
  left_numbers.each do |l_number|
    matches += 1 if right_numbers.include?(l_number)
  end
  cards << Card.new(card_id, matches)
end
total_cards = Hash.new(0)
cards.each do |card|
  total_cards[card.card_id] += 1
  card.matches.times do |i|
    next_card_id = card.card_id + i + 1
    break if next_card_id > cards.size 
    total_cards[next_card_id] += total_cards[card.card_id]
  end
end

total2 = total_cards.values.sum
puts total2