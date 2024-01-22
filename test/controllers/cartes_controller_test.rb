require "test_helper"

class CartesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cartes_new_url
    assert_response :success
  end

  test "should get create" do
    get cartes_create_url
    assert_response :success
  end

  test "should get show" do
    get cartes_show_url
    assert_response :success
  end

  test "should get edit" do
    get cartes_edit_url
    assert_response :success
  end

  test "should get update" do
    get cartes_update_url
    assert_response :success
  end

  test "should get destroy" do
    get cartes_destroy_url
    assert_response :success
  end
end
