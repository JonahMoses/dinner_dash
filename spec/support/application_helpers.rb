module UserHelpers

  def register_user
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

  def add_order_to_user
    visit '/items'
    click_link_or_button 'Show'
    click_link_or_button 'Add to Cart'
  end

end

RSpec.configure do |c|
  c.include UserHelpers
end
