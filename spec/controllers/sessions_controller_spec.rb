require 'spec_helper'

describe SessionsController do

  describe "new session" do # move to user
    it "sets session[:user_id] for valid user" do
      User.create!(:email => "simon@example.com", :full_name => "yep",
                          :password => "foobar", :password_confirmation => "foobar")
      user = User.authenticate("simon@example.com", "foobar")
      user.should_not be_nil
    end
  end

  describe "logging out" do
    it "routes to /log_out" do
      expect(:get => "/log_out").to route_to(
        :controller => "sessions",
        :action => "destroy"
      )
    end

    xit "destroys session on log out" do
      visit ("/log_in")
      visit ("/log_out")
      session[:user_id].should be_nil
    end
  end

end
