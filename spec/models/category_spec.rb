require 'spec_helper'

describe Category do
  # Seriously, don't get attached to this style...
  # just a good starting point...[Sean]
  it { should be }
  it { should have_many(:items).through(:item_categories) }
  it { should validate_uniqueness_of(:name) }

  context "when given the correct information" do
    it "creates a category" do
      result = Category.create(name: "Lunch")
      expect(result).to be_valid
    end

    it "does not create category when the name already exists" do
      Category.create(name: "Lunch")
      result = Category.create(name: "Lunch")
      expect(result).not_to be_valid
    end

    it "category name is case sensitive" do
      Category.create(name: "lunch")
      result = Category.create(name: "Lunch")
      expect(result).not_to be_valid
    end
  end
end



