def substrings(input, dictionary)
  hash = Hash.new(0)
  strings = input.gsub(/[^0-9a-z ]/i,"").split(" ")
  dictionary.each {|word|
    strings.each {|match|
      if match.downcase.include? word
        hash[word] += 1
      end
    }
  }
  hash
end
dictionary = ["below","down","go","going","horn",
              "how","howdy","it","i","low","own",
              "part","partner","sit"]
              
p substrings("below", dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)