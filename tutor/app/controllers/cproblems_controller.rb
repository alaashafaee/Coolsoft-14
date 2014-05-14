class CproblemsController < ApplicationController
  
  def show
  	puts "<<<<<<<<<<<<<<<<<<<<<<<"
	puts params
  	@contest = Contest.find_by_id(1)
  	@problem = Cproblem.find_by_id(params[:id])
	if @problem.nil?
		render "problem_not_found"
	end
  end

  def create
  end

  def new
  end

  def index
  end

  private
  def param
  	params.permit(:contest_id, :probelm_id)
  end
end
