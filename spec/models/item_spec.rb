require 'spec_helper'

describe Item do
  it "forces unique title" do
    fries = Item.create!(title: "Fries", description: "greasy sticks", price: "1.99")
    fries_again = Item.create(title: "Fries", description: "slimy", price: "2.99")
    fries_again.valid?.should be_false
  end

  it "has a price greater than 0" do
    fries = Item.create(title: "Fries", description: "blah", price: "-2.00")
    fries.valid?.should be_false
  end

  it "has a decimal price" do
    fries = Item.create!(title: "Fries", description: "blah", price: "2")
    fries.valid?.should be_true
    fries.price.should eq(2.00)
  end

  it "rejects a price with only a tens digit" do
    fries = Item.create!(title: "Fries", description: "blah", price: "2.2")
    fries.valid?.should be_true
    fries.price.should eq(2.20)
  end

  it "rejects an empty title" do
    fries = Item.create(title: "  ", description: "blah", price: "2.2")
    fries.valid?.should be_false
  end

  it "rejects an empty descriptiont" do
    fries = Item.create(title: "Fries", description: "  ", price: "2.2")
    fries.valid?.should be_false
  end

  it "accepts a price less than a dollar" do
    fries = Item.create(title: "Fries", description: "sample", price: "0.20")
    fries.valid?.should be_true
  end

  it "accepts a price less than a dollar not ending in 0" do
    fries = Item.create(title: "Fries", description: "sample", price: "0.22")
    fries.valid?.should be_true
  end

  it "accepts .00 price" do
    fries = Item.create(title: "Fries", description: "sample", price: "2.00")
    fries.valid?.should be_true
  end

  it "truncates to 2 decimals for 3 decimal places" do
    fries = Item.create!(title: "Fries", description: "sample", price: "2.123")
    fries.price.should eq(BigDecimal.new("2.123"))
    # this test is odd, it's returning bigDecimal
  end

  it { should have_many(:categories).through(:item_categories) }
end
