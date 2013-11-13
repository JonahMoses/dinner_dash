require 'spec_helper'

describe "the checkout process" do

  before :all do
    register_user
    make_an_item
    add_item_to_order
  end

  it "updates order and directs to confirmation page" do
    visit '/orders'
    click_on 'Show'
    click_on 'Purchase'
    within('.confirmation-banner') do
      expect(page).to have_content 'Confirmation'
    end
  end

end

describe "the checkout process for a guest" do

  before :all do
    make_an_item
    visit '/'
    click_on 'Log Out'
  end

  it "brings user to sign up page and back to order" do
    add_item_to_order
    visit '/orders'
    click_on 'Show'
    click_on 'Purchase'
    #within('h1') do
      expect(page).to have_content 'Sign Up'
    #end
    fill_in 'user_email',                 :with => "newUser@example.com"
    fill_in 'user_full_name',             :with => "new"
    fill_in 'user_display_name',          :with => "new"
    fill_in 'user_password',              :with => "foobar"
    fill_in 'user_password_confirmation', :with => "foobar"
    click_link_or_button 'Create User'
    click_on 'Purchase'
    within('.confirmation-banner') do
      expect(page).to have_content 'Confirmation'
    end
  end

end

describe "making a new order after purchasing an order" do

  before :all do
    #make_an_item_via_db
  end

  it "should create a new order after purchasing" do
    register_user
    add_item_to_order
    visit '/orders'
    click_on 'Show'
    click_on 'Purchase'
    add_item_to_order
    within('.unsubmitted') do
      click_on('Show')
    end
    # will have to look for first item_quanity
    within('.item_quantity') do
      expect(page).to have_content('1')
    end
  end

end
