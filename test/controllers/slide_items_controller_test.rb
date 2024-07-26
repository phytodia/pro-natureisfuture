require "test_helper"

class SlideItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get slide_items_new_url
    assert_response :success
  end

  test "should get create" do
    get slide_items_create_url
    assert_response :success
  end

  test "should get edit" do
    get slide_items_edit_url
    assert_response :success
  end

  test "should get update" do
    get slide_items_update_url
    assert_response :success
  end

  test "should get destroy" do
    get slide_items_destroy_url
    assert_response :success
  end
end
