require "test_helper"

class CarteCadeausControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get carte_cadeaus_index_url
    assert_response :success
  end

  test "should get new" do
    get carte_cadeaus_new_url
    assert_response :success
  end

  test "should get create" do
    get carte_cadeaus_create_url
    assert_response :success
  end

  test "should get destroy" do
    get carte_cadeaus_destroy_url
    assert_response :success
  end
end
