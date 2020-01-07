require "./caesar.rb"

describe "Caesar" do
  it "returns unwrapped cipher" do
    expect(caesar_cipher("adam", 1)).to eql("bebn")
  end

  it "returns wrapped cipher" do
    expect(caesar_cipher("adam", 28)).to eql("cfco")
  end

  it "returns negatively wrapped cipher" do
    expect(caesar_cipher("adam", -1)).to eql("zczl")
  end

  it "handles capital letters" do
    expect(caesar_cipher("AdaM", 80)).to eql("CfcO")
  end

  it "ignores punctuation" do
    expect(caesar_cipher("Adam, the great!", 1)).to eql("Bebn, uif hsfbu!")
  end
end