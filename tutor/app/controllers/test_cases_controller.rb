class TestCasesController < ApplicationController
# [Add test case-story 4.8]
# Shows all the test cases.
# Parameters: None
# Returns:List of all the test cases related to a certain problem.
# Author: Lin 
def index 
    @test_cases = TestCase.all
end
# [Add test case-story 4.8]
# Display the form that is used to add a test case. 
# Parameters: None
# Returns: None
# Author: Lin 
def new 
    @test_case = TestCase.new()  
end
# [Add test case-story 4.8]
# Saves the new test case into the database.(What the form the 'new' method will submit to)  
# Parameters: None
# Returns: In case of success a flash notice will appear:"Post created successfully"
#          In case of failure a flash notice will appear:"Can't add test case!"
# Author: Lin
def create
@test_case = TestCase.new(post_params) 
    if @test_case.save
        flash[:notice] = "Post created successfully"
        redirect_to :back
    else
        flash[:notice] = "Can't add test case!"
        redirect_to :back
	end 
end
# [Add test case-story 4.8]
# private method. Controls the test case parameters that can be accessed.
# Parameters: None
# Returns: None
# Author: Lin
private
def post_params
    params.require(:test_case).permit(:input, :output)
end
end
