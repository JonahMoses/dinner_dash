require 'spec_helper'

describe "a user's orders", :type => :feature do

  xit "for a signed in user it lists orders on orders#index" do
    register_user
    visit('/users/1/orders')
    click_link_or_button('show_link')
    expect(page).to have_content 'monkeys'
  end

  it "shows orders for current_user" do
    register_user
    make_an_item
    add_order_to_user
    visit('/users/1/orders')
    expect(page).to have_content 'unsubmitted'
  end

  xit "does not show orders for a different user" do
    register_user
    visit('/users/1/orders')
    # page should not have an order
  end

end

