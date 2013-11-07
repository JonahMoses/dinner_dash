require 'spec_helper'

describe "the signup process", :type => :feature do

  it "signs me up" do
    visit '/sign_up'
    fill_in 'user_email',                 :with => "bj@example.com"
    fill_in 'user_full_name',             :with => "Bo Jangles"
    fill_in 'user_display_name',          :with => "BJ"
    fill_in 'user_password',              :with => "foobarbaz"
    fill_in 'user_password_confirmation', :with => "foobarbaz"
    click_link_or_button 'Create User'
    expect(page).to have_content 'Signed up!'
  end

end

describe "the signin process" do
  before :each do
    register_user
  end

  it "logs me in" do
    within("#flash_notice") do
      expect(page).to have_content 'Logged in'
    end
  end

  it "logs me out" do
    visit '/'
    click_link_or_button 'Log out'
    expect(page).to have_content 'Logged out'
    expect(page).to have_content 'log in'
  end

end

describe "guest user" do

  it "cannot edit item" do
    item = make_an_item_via_db
    visit edit_item_path(item)
    page.should have_content("Not authorized")
  end

end

describe "member" do

  it "cannot edit item" do
    item = make_an_item_via_db
    register_user
    visit edit_item_path(item)
    page.should have_content("Not authorized")
  end

end

describe "admin user" do

  it "can edit an item" do
    item = make_an_item_via_db
    register_admin_user
    visit edit_item_path(item)
    page.should_not have_content("Not authorized")
  end

end


