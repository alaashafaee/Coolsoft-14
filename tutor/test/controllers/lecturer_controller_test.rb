require 'test_helper'

class LecturerControllerTest < ActionController::TestCase
  test "should get showCorrectAnswers" do
    get :showCorrectAnswers
    assert_response :success
  end

  test "should get average" do
    get :average
    assert_response :success
  end

  test "should get time" do
    get :time
    assert_response :success
  end

  test "should get showAttempts" do
    get :showAttempts
    assert_response :success
  end

end
