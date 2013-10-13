require 'test_helper'

class PokerControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get tables" do
    get :tables
    assert_response :success
  end

  test "should get create_table" do
    get :create_table
    assert_response :success
  end

  test "should get game" do
    get :game
    assert_response :success
  end

end
