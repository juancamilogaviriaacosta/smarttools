require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get restore" do
    get :restore
    assert_response :success
  end

end
