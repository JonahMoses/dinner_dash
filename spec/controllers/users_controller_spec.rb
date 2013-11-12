require 'spec_helper'

describe UsersController do

  before :all do
    register_changeable_user
  end

  describe "routing" do
    it "routes to #new" do
      expect(:get => "/sign_up").to route_to(
        :controller => "users",
        :action => "new"
      )
    end
  end

  describe "updating a user's information" do
    it "updates email address" do
      user = User.find_by(:email => "confused@example.com")
      user.update(:email => "fools@example.com")
      expect(user.email).should eq("fools@example.com")
    end
  end

end
