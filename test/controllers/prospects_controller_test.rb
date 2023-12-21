require "test_helper"

class ProspectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get prospects_index_url
    assert_response :success
  end

  test "should get show" do
    get prospects_show_url
    assert_response :success
  end

  test "should get new" do
    get prospects_new_url
    assert_response :success
  end

  test "should get create" do
    get prospects_create_url
    assert_response :success
  end

  test "should get edit" do
    get prospects_edit_url
    assert_response :success
  end

  test "should get update" do
    get prospects_update_url
    assert_response :success
  end

  test "should get destroy" do
    get prospects_destroy_url
    assert_response :success
  end
end
