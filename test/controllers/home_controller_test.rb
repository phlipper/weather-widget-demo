require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "returns ok" do
    get root_url
    assert_response :success
  end
end
