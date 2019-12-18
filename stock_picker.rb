def stock_picker(prices)
  profit = 0
  buy = nil
  sell = nil
  len = prices.length
  prices.each_index {|b|
    (b...len).each {|s|
      if b < s && (prices[s] - prices[b]) > profit
        profit = prices[s] - prices[b]
        buy = b
        sell = s
      end
    }
  }
  return [buy, sell]
end