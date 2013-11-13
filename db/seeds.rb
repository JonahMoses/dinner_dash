class Seeder

  def create_data
    create_categories
    create_orders
    10.times do
      create_item
    end
    create_users
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
    all_categories = Category.all
    item.categories << all_categories.sample
    item.categories << all_categories.sample
    item.categories << all_categories.sample
    if item.valid?
      puts "Created item #{item.title}"
    else
      puts "Not valid item: #{item.title}"
    end

    item.save
  end

  def create_user_1
    user = User.create(
      email: "demo+franklin@jumpstartlab.com",
      full_name: "Franklin Webber",
      password: "password",
      password_confirmation: "password"
    )
   user_validation(user)
  end

  def create_user_2
    user = User.create(
      email: "demo+jeff@jumpstartlab.com",
      full_name: "Jeff",
      display_name: "j3",
      password: "password",
      password_confirmation: "password"
    )
    user_validation(user)
  end

  def create_user_3
    user = User.create(
      email: "demo+katrina@jumpstartlab.com",
      full_name: "Katrina Owen",
      display_name: "kytrinyx",
      password: "password",
      password_confirmation: "password",
      admin: "true"
    )
    user_validation(user)
  end

  def create_admin_user
    user = User.create(
      email: "admin@example.com",
      full_name: "admin",
      display_name: "admin",
      password: "password",
      password_confirmation: "password"
    )
    if user.valid?
      puts "Created user #{user.full_name}"
      user.admin = true
      user.save
      if user.admin
        puts "Set #{user.email} to be an admin"
      else
        puts "Failed to set #{user.email} to be an admin"
      end
    else
      puts "Not valid user: #{user.full_name}"
    end
  end

  def user_validation(user)
    if user.valid?
      puts "Created user #{user.full_name}"
    else
      puts "Not valid user: #{user.full_name}"
    end
  end

  def create_users
    create_user_1
    create_user_2
    create_user_3
    create_admin_user
  end

  def create_orders
    order_statuses.each do |order_status|
      order = Order.create(:status => order_status)
      puts "Created order: #{order.status}"
    end
  end

  def order_statuses
   [
     'unsubmitted',
     'unsubmitted',
     'paid',
     'paid',
     'completed',
     'completed',
     'cancelled',
     'cancelled'
   ]
  end

end

Seeder.new.create_data
