require "test_helper"

class CrmControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get crm_index_url
    assert_response :success
  end

  test "should get show" do
    get crm_show_url
    assert_response :success
  end

  test "should get new" do
    get crm_new_url
    assert_response :success
  end

  test "should get create" do
    get crm_create_url
    assert_response :success
  end

  test "should get edit" do
    get crm_edit_url
    assert_response :success
  end

  test "should get update" do
    get crm_update_url
    assert_response :success
  end

  test "should get destroy" do
    get crm_destroy_url
    assert_response :success
  end
end
