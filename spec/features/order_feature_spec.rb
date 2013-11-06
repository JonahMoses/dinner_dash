require 'spec_helper'

describe "a logged in user's order" do

  before :all do
    register_user
    make_an_item
  end

  it "starts with no order" do
    log_in_user
    visit '/orders'
    expect(page).not_to have_content 'unsubmitted'
  end

  it "shows the added item in the order" do
    log_in_user
    visit '/items'
    click_on('Show')
    click_on('Add to Cart')
    within("#order_items_index_table") do
      expect(page).to have_content 'unsubmitted'
    end
  end

end

describe "a guest user's order" do
  before :all do
    make_an_item
  end

  it "adds item to an order" do
    visit '/items'
    click_on('Show')
    click_on('Add to Cart')
    within("#order_items_index_table") do
      expect(page).to have_content 'unsubmitted'
    end
  end

  it "keeps item in cart after signing up" do
    visit '/items'
    click_on('Show')
    click_on('Add to Cart')
    within("#order_items_index_table") do
      expect(page).to have_content 'unsubmitted'
    end
    click_on('Become a member')
    fill_in 'user_email',                 :with => "armstrong@example.com"
    fill_in 'user_full_name',             :with => "doping"
    fill_in 'user_display_name',          :with => "tour"
    fill_in 'user_password',              :with => "foobarbaz"
    fill_in 'user_password_confirmation', :with => "foobarbaz"
    click_link_or_button 'Create User'
    within('#flash_notice') do
      expect(page).to have_content 'Signed up!'
    end
    within('#order_items_index_table') do
      expect(page).to have_content 'unsubmitted'
    end
    click_on('Show')
    within('#order_items_table') do
      expect(page).to have_content 'fries'
    end
  end

end
