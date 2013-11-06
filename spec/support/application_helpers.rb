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
    click_link_or_button 'Save changes'
  end

  def log_in_user
    visit '/log_in'
    fill_in 'email', :with => "user@example.com"
    fill_in 'password', :with => "foobarbaz"
    click_link_or_button 'Save changes'
  end

  def make_an_item
    # will need to be an admin
    visit '/items'
    click_link_or_button 'New Item'
    fill_in 'item_title', :with => 'fries'
    fill_in 'item_description', :with => 'wet'
    fill_in 'item_price', :with => '1.99'
    click_link_or_button 'Create Item'
  end

end

RSpec.configure do |c|
  c.include UserHelpers
end
