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
    fries = Item.create(title: "Fries", description: "blah", price: "2")
    fries.valid?.should be_false
  end

  it "rejects a price with only a tens digit" do
    fries = Item.create(title: "Fries", description: "blah", price: "2.2")
    fries.valid?.should be_false
  end

  it "rejects an empty title" do
    fries = Item.create(title: "  ", description: "blah", price: "2.2")
    fries.valid?.should be_false
  end

  it "rejects an empty descriptiont" do
    fries = Item.create(title: "Fries", description: "  ", price: "2.2")
    fries.valid?.should be_false
  end

end
