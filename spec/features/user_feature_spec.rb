require 'spec_helper'

describe "the signup process", :type => :feature do

  it "signs me up" do
    visit '/sign_up'
    fill_in 'user_email', :with => "user@example.com"
    fill_in 'user_full_name', :with => "Bo Jangles"
    fill_in 'user_display_name', :with => "BJ"
    fill_in 'user_password', :with => "foobarbaz"
    fill_in 'user_password_confirmation', :with => "foobarbaz"
    click_link_or_button 'Create User'
    expect(page).to have_content 'Signed up!'
  end

end

describe "the signin process" do
  before :each do
    User.create!(:email => "user@example.com",
                 :full_name => "bo jangles",
                 :display_name => "bj",
                 :password => "foobarbaz",
                 :password_confirmation => "foobarbaz")
  end

  it "logs me in" do
    register_user
    expect(page).to have_content 'Logged in'
  end

  it "logs me out" do
    register_user
    visit '/'
    click_link_or_button 'Log out'
    expect(page).to have_content 'Logged out'
    expect(page).to have_content 'log in'
  end

end

