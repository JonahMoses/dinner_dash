class Seeder

  def create_data
    create_categories
    10.times do
      create_item
    end
    # 2.times do
      create_users
    # end
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
      description: Faker::Lorem.words(5).join(" "),
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

  def create_user_1
    user = User.create(
      email: "demo+franklin@jumpstartlab.com",
      full_name: "Franklin Webber",
      password: "password",
      password_confirmation: "password"
    )
    if user.valid?
      puts "Created user #{user.full_name}"
    else
      puts "Not valid user: #{user.full_name}"
    end
  end

  def create_user_2
    user = User.create(
      email: "demo+jeff@jumpstartlab.com",
      full_name: "Jeff",
      display_name: "j3",
      password: "password",
      password_confirmation: "password"
    )
    if user.valid?
      puts "Created user #{user.full_name}"
    else
      puts "Not valid user: #{user.full_name}"
    end
  end

  # def user_3
  #   User.create(
  #     email: "demo+katrina@jumpstartlab.com",
  #     full_name: "Katrina Owen",
  #     display_name: "kytrinyx",
  #     password: "password"
  #     password_confirmation: "password"
  #   )
  # end

  def create_users
    create_user_1
    create_user_2
    # create_user_3
  end

end

Seeder.new.create_data
