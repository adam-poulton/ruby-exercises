require "./enumerable.rb"

describe Enumerable do
  describe "#my_each" do
    it "yields each item in an enumerable to the block" do
      array = ["foo", "bar", "baz"]
      result = ""
      array.my_each{|i| result << i}
      expect(result).to eql("foobarbaz")
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
end