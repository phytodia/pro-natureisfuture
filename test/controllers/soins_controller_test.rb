require "test_helper"

class SoinsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get soins_index_url
    assert_response :success
  end

  test "should get show" do
    get soins_show_url
    assert_response :success
  end

  test "should get visage" do
    get soins_visage_url
    assert_response :success
  end

  test "should get corps" do
    get soins_corps_url
    assert_response :success
  end

  test "should get massages" do
    get soins_massages_url
    assert_response :success
  end
end
