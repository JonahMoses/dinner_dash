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
    save_and_open_page
    within('.confirmation-banner') do
      expect(page).to have_content 'Confirmation'
    end
  end

end
