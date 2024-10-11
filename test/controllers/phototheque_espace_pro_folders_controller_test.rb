require "test_helper"

class PhotothequeEspaceProFoldersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get phototheque_espace_pro_folders_new_url
    assert_response :success
  end

  test "should get create" do
    get phototheque_espace_pro_folders_create_url
    assert_response :success
  end

  test "should get edit" do
    get phototheque_espace_pro_folders_edit_url
    assert_response :success
  end

  test "should get update" do
    get phototheque_espace_pro_folders_update_url
    assert_response :success
  end

  test "should get destroy" do
    get phototheque_espace_pro_folders_destroy_url
    assert_response :success
  end
end
