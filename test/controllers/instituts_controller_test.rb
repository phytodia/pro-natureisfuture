require "test_helper"

class InstitutsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get instituts_index_url
    assert_response :success
  end

  test "should get show" do
    get instituts_show_url
    assert_response :success
  end

  test "should get new" do
    get instituts_new_url
    assert_response :success
  end

  test "should get create" do
    get instituts_create_url
    assert_response :success
  end

  test "should get edit" do
    get instituts_edit_url
    assert_response :success
  end

  test "should get update" do
    get instituts_update_url
    assert_response :success
  end

  test "should get destroy" do
    get instituts_destroy_url
    assert_response :success
  end
end
