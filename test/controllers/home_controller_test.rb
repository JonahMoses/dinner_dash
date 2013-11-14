require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get home_page" do
    get :home_page
    assert_response :success
  end

end
