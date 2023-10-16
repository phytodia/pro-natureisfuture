require "test_helper"

class EspaceProControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get espace_pro_index_url
    assert_response :success
  end
end
