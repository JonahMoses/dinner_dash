class Seeder

  def create_data
    create_categories
    10.times do
      create_item
    end
  end

private

  def create_categories
    category_names.each do |cat_name|
      category = Category.create(:name => cat_name)
      puts "Created category: #{category.name}"
    end
  end

  def category_names
   [
     'healthy',
     'chicken',
     'veg',
     'meat',
     'dessert',
     'sides',
     'sauces',
     'soups',
     'comfort food'
   ]
  end

  def sample_prices
    [10.02, 1.04, 9.99, 0.99]
  end

  def create_item
    item = Item.create(
      title: Faker::Lorem.words(1).join(" "),
      description: Faker::Lorem.words(10).join(" "),
      active: true,
      price: sample_prices.sample.to_s
    )
    #item.categories << Category.last
    if item.valid?
      puts "Created item #{item.title}"
    else
      puts "Not valid item: #{item.title}"
    end
  end

end

Seeder.new.create_data
