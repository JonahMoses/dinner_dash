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
    add_item_to_order
    within("#order_items_index_table") do
      expect(page).to have_content 'unsubmitted'
    end
  end

  it "keeps item in cart after signing up" do
    add_item_to_order
    within("#order_items_index_table") do
      expect(page).to have_content 'unsubmitted'
    end
    click_on('Become a member') # should probably say Become a member (case?)
    register_new_user
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

describe "maintaining a single cart over multiple logins" do
  before :all do
    make_an_item
  end

  after :each do
    visit '/log_out'
  end

  it "keeps same cart for a user after log out and log back in" do
    register_user #=> user@example.com
    add_item_to_order
    click_on('Log Out')
    register_user #=> user@example.com
    add_item_to_order # is it same item?
    click_on('Show')
    within('.item_quantity') do
      expect(page).to have_content('2')
    end
  end
end
