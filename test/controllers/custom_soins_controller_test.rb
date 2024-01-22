require "test_helper"

class CustomSoinsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get custom_soins_new_url
    assert_response :success
  end

  test "should get create" do
    get custom_soins_create_url
    assert_response :success
  end

  test "should get edit" do
    get custom_soins_edit_url
    assert_response :success
  end

  test "should get update" do
    get custom_soins_update_url
    assert_response :success
  end

  test "should get destroy" do
    get custom_soins_destroy_url
    assert_response :success
  end
end
