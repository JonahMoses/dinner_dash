module UserHelpers

  def register_user
    User.where(:email => "user@example.com").first_or_create(
                :email => "user@example.com",
                :full_name => "bo jangles",
                :display_name => "bj",
                :password => "foobarbaz",
                :password_confirmation => "foobarbaz")
    visit '/log_in'
    fill_in 'email', :with => "user@example.com"
    fill_in 'password', :with => "foobarbaz"
    click_button 'Log In'
  end

  def register_admin_user
    User.where(:email => "admin@example.com").first_or_create(
                :email => "admin@example.com",
                :full_name => "bo jangles",
                :display_name => "bj",
                :password => "foobarbaz",
                :password_confirmation => "foobarbaz",
                :admin => true)
    visit '/log_in'
    fill_in 'email', :with => "admin@example.com"
    fill_in 'password', :with => "foobarbaz"
    click_button 'Log In'
  end

  def log_in_user
    visit '/log_in'
    fill_in 'email', :with => "user@example.com"
    fill_in 'password', :with => "foobarbaz"
    click_button 'Log In'
  end

  def make_an_item_via_db
    Item.create!(:title => 'potatoe wedges',
                :description => 'wet',
                :price => '1.99')
  end

  def make_an_item
    # will need to be an admin
    user = User.where(:email => "admin1@example.com").first_or_create(
                :email => "admin1@example.com",
                :full_name => "admin",
                :password => "foobar",
                :password_confirmation => "foobar",
                :admin => true)
    visit '/log_in'
    fill_in 'email', :with => "admin1@example.com"
    fill_in 'password', :with => "foobar"
    click_button 'Log In'

    visit '/items'
    click_on 'New Item'
    fill_in 'item_title', :with => 'fries'
    fill_in 'item_description', :with => 'wet'
    fill_in 'item_price', :with => '1.99'
    click_button 'Create Item'
  end

  def add_item_to_order
    visit '/items'
    click_on('Add to Cart')
  end

  def register_new_user
    fill_in 'user_email',                 :with => "armstrong@example.com"
    fill_in 'user_full_name',             :with => "doping"
    fill_in 'user_display_name',          :with => "tour"
    fill_in 'user_password',              :with => "foobarbaz"
    fill_in 'user_password_confirmation', :with => "foobarbaz"
    click_button 'Create User'
  end

end

RSpec.configure do |c|
  c.include UserHelpers
end
