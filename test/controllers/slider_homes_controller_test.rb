require "test_helper"

class SliderHomesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get slider_homes_edit_url
    assert_response :success
  end

  test "should get update" do
    get slider_homes_update_url
    assert_response :success
  end
end
