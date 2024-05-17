require "test_helper"

class StockInstitutsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stock_instituts_index_url
    assert_response :success
  end

  test "should get edit" do
    get stock_instituts_edit_url
    assert_response :success
  end

  test "should get update" do
    get stock_instituts_update_url
    assert_response :success
  end
end
