input = File.readlines('Day7-input.txt').map(&:chomp)
total = 0
Card = Struct.new(:hand, :bet)
cards = []
input.each do |line|
    hand, bet = line.split(' ')
    cards << Card.new(hand, bet.to_i)
end
CARD_ORDER = '23456789TJQKA'

HAND_RANKINGS = {
  five_of_a_kind: 7,
  four_of_a_kind: 6,
  full_house: 5,
  three_of_a_kind: 4,
  two_pair: 3,
  one_pair: 2,
  high_card: 1
}

def hand_type_and_key_cards(hand)
  counts = hand.chars.tally
  case counts.values.sort.reverse
  when [5] then [:five_of_a_kind]
  when [4, 1] then [:four_of_a_kind]
  when [3, 2] then [:full_house]
  when [3, 1, 1] then [:three_of_a_kind]
  when [2, 2, 1] then [:two_pair]
  when [2, 1, 1, 1] then [:one_pair]
  else [:high_card]
  end
end

def compare_hands(hand1, hand2)
  type1 = hand_type_and_key_cards(hand1)
  type2 = hand_type_and_key_cards(hand2)

  hand_comparison = HAND_RANKINGS[type1.first] <=> HAND_RANKINGS[type2.first]
  return hand_comparison unless hand_comparison == 0

  hand1.chars.zip(hand2.chars).each do |card1, card2|
    card_comparison = CARD_ORDER.index(card1) <=> CARD_ORDER.index(card2)
    return card_comparison if card_comparison != 0
  end
  0 
end

def merge_sort(cards)
  return cards if cards.length <= 1
  work_array = cards.map { |card| [card] }
  while work_array.length > 1
    merged_array = []
    work_array.each_slice(2) do |left, right|
      merged_array << merge(left, right || [])
    end
    work_array = merged_array
  end
  work_array.flatten
end

def merge(left, right)
  result = []
  until left.empty? || right.empty?
    if compare_hands(left.first.hand, right.first.hand) == 1
      result << left.shift
    else
      result << right.shift
    end
  end
  result.concat(left).concat(right)
end

sorted_cards = merge_sort(cards)
sorted_cards.each_with_index do |card, index|
  total += (1000-(index)) * card.bet
  puts card.hand 
  puts index 
end

puts total