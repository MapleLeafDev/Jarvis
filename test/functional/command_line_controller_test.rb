require 'test_helper'

class CommandLineControllerTest < ActionController::TestCase
  test "should get run" do
    get :run
    assert_response :success
  end

end
