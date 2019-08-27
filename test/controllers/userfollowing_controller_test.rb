require 'test_helper'

class UserfollowingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get userfollowing_index_url
    assert_response :success
  end

end
