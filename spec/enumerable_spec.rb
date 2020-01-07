require "./enumerable.rb"

describe Enumerable do
  describe "#my_each" do
    it "yields each item in an enumerable to the block" do
      array = ["foo", "bar", "baz"]
      result = ""
      array.my_each{|i| result << i}
      expect(result).to eql("foobarbaz")
    end
    it "does not modify the original enumerable" do
      array = ["foo", "bar", "baz"]
      result = ""
      array.my_each{|i| result << i}
      expect(array).to eql(["foo", "bar", "baz"])
    end
  end

  describe "#my_each_with_index" do
    it "yields each item & index in an enumerable to the block" do
      array = ["foo", "bar", "baz"]
      result = ""
      array.my_each_with_index{|v, i| result << "#{i}:#{v}."}
      expect(result).to eql("0:foo.1:bar.2:baz.")
    end
  end

  describe "#my_select" do
    it "selects even numbers" do
      array = [1,2,3,4,5,6,7,8]
      evens = array.my_select { |num| num % 2 == 0 }
      expect(evens).to eql([2,4,6,8])
    end

    it "does not modify the original enumerable" do
      array = [1,2,3,4,5,6,7,8]
      evens = array.my_select { |num| num % 2 == 0 }
      expect(array).to eql([1,2,3,4,5,6,7,8])
    end
  end

  describe "#my_filter" do
    it "is an alias of #my_select" do
      array = [1,2,3,4,5,6,7,8]
      evens = array.my_select { |num| num % 2 == 0 }
      expect(evens).to eql([2,4,6,8])
    end
  end

  describe "#my_all?" do
    it "returns true when enumerable is empty" do
      array = []
      expect(array.my_all?).to be_truthy
    end
    it "returns false when enumerable contains falsey values" do
      array = [nil, false]
      expect(array.my_all?{|i| i.nil?}).to be_falsey
    end
    it "returns false when no elements conform" do
      array = [1,2,3,4,5,6,7,8,9]
      expect(array.my_all?{|i| i>10}).to be_falsey
    end
    it "returns false when some elements conform" do
      array = [1,2,3,4,5,6,7,8,9]
      expect(array.my_all?{|i| i>1}).to be_falsey
    end
    it "returns true when all elements conform" do
      array = [1,2,3,4,5,6,7,8,9]
      expect(array.my_all?{|i| i>0}).to be_truthy
    end
  end

  describe "#my_any?" do
    it "returns false when enumerable is empty" do
      expect([].my_any?{|i|i}).to be_falsey
    end
    it "returns true when at least one element conforms" do
      array = [1,2,3,4,5,6,7,8,9]
      expect(array.my_any?{|i|i%2==0}).to be_truthy
    end
    it "returns true when all elements conform" do
      array = [1,2,3,4,5,6,7,8,9]
      expect(array.my_any?{|i|i>0}).to be_truthy
    end
    it "returns false when no elements conform" do
      array = [1,2,3,4,5,6,7,8,9]
      expect(array.my_any?{|i|i>10}).to be false
    end
  end

  describe "#my_none?" do
    it "returns false when enumerable is empty" do
      expect([].my_none?{|i|i}).to be true
    end
    it "returns true when no elements conform" do
      expect([1,2,3,4,5].my_none?{|i| i<0}).to be true
    end
    it "returns false when at least one element conforms" do
      expect([1,2,3,4,5].my_none?{|i|i==5}).to be false
    end
    it "returns false when all elements conform" do
      expect([1,2,3,4,5].my_none?{|i|i>0}).to be false
    end
  end

  describe "#my_count" do
    it "returns 0 on an empty enumerable" do
      expect([].my_count{|i| i.nil?}).to eql(0)
    end
    it "returns 0 when no elements conform" do
      expect([1,2,3,4,5].my_count{|i| i.nil?}).to eql(0)
    end
    it "returns the number of conforming elements" do
      expect([1,2,3,4,5].my_count{|i| i>2}).to eql(3)
    end
  end

  describe "#my_map" do
    it "operates on each element in the enumerable" do
      array = [1,2,3,4,5]
      expect(array.map{|i|i*10}).to eql([10,20,30,40,50])
    end
    it "leaves the original enumerable unchanged" do
      array = [1,2,3,4,5]
      result = array.map{|i|i*10}
      expect(array).to eql([1,2,3,4,5])
    end
    it "accepts a proc" do
      array = [1,2,3,4,5]
      times10 = Proc.new {|i|i*10}
      expect(array.map(&times10)).to eql([10,20,30,40,50])
    end
  end

  describe "#my_inject" do
    it "returns accumilator on empty enumerable" do
      expect([].my_inject(10){|i|i}).to eql(10)
    end
    it "sums the elements in array" do
      expect([1,2,3,4,5].my_inject(0){|acc, item| acc + item}).to eql(15)
    end
  end
end