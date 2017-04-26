require 'test_helper'

class GalleriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get galleries_create_url
    assert_response :success
  end

end
