input = File.read('input.txt')

def parser(input)
    total = 0
    input.each_line do |row|
        row = row.gsub(/[a-zA-Z\s]/, '')
        next if row.empty?
        first_digit = row[0]
        last_digit = row[-1]
        tempnumber = "#{first_digit}#{last_digit}"
        puts tempnumber
        total += tempnumber.to_i
    end
    return total
end
  
puts parser(input)
