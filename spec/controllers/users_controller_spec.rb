require 'spec_helper'

describe UsersController do

  describe "routing" do
    it "routes to #new" do
      expect(:get => "/sign_up").to route_to(
        :controller => "users",
        :action => "new"
      )
    end
  end

end
