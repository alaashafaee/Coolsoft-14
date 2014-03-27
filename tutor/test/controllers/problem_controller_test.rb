require 'test_helper'

class ProblemControllerTest < ActionController::TestCase
  test "should get Create_Edit_Problem_Page" do
    get :Create_Edit_Problem_Page
    assert_response :success
  end

end
