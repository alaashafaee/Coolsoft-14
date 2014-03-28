class TestCasesController < ApplicationController

	def index 
    @test_cases = TestCase.all
  end

  #Lin: Displays all test cases.
  def new 
    @test_case = TestCase.new(params[:id])  
  end

  #Lin: Saves the test case into the data base. 
  #     It is where the test case form will submit to. 
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

#Lin: This private message is used to control the parameters that can be accessed.
private
  def post_params
    params.require(:test_case).permit(:input, :output)
  end
end
