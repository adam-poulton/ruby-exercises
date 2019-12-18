# Use String.ord and Integer.chr to apply offset

# A = 65
# Z = 90
# a = 97
# z = 122

def caesar_cipher(input, offset)
  if offset < 0
    newOffset = (26 - (offset.abs() % 26)) % 26
  else
    newOffset = offset % 26
  end
  result = ""
  input.each_char {|char|
    num = char.ord
    if num >= 65 && num <= 90
      newNum = num + newOffset
      if newNum > 90
        newNum = newNum - 26
      end
    elsif num >= 97 && num <= 122
      newNum = num + newOffset
      if newNum > 122
        newNum = newNum - 26
      end
    else
      newNum = num
    end
    result += newNum.chr
  }
  return result
end


puts "Enter string:"
input = gets.chomp
puts "Enter offset:"
offset = gets.chomp.to_i
puts caesar_cipher(input, offset)