require 'test_helper'

class AuthorfollowingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get authorfollowing_index_url
    assert_response :success
  end

end
