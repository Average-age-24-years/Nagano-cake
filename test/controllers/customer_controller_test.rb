require 'test_helper'

class CustomerControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get customer_show_url
    assert_response :success
  end

  test "should get withdraw_confirm" do
    get customer_withdraw_confirm_url
    assert_response :success
  end

  test "should get edit" do
    get customer_edit_url
    assert_response :success
  end

end
