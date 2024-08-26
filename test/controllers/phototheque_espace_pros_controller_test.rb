require "test_helper"

class PhotothequeEspaceProsControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get phototheque_espace_pros_upload_url
    assert_response :success
  end

  test "should get delete" do
    get phototheque_espace_pros_delete_url
    assert_response :success
  end
end
