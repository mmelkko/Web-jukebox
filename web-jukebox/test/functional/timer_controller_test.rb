require 'test_helper'

class TimerControllerTest < ActionController::TestCase
  test "should get now" do
    get :now
    assert_response :success
  end

end
