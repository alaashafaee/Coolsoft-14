class CoursesController < ApplicationController
  
  def destroy
  	Course.find(params[:id]).destroy
    flash[:success] = "Course deleted."
    redirect_to :action => 'show'
  end

  def create
  end

  def show
  end

  def manage
       id =  params[:id]
    course = Course.find_by_id(id)
     @discussionBoard = course.discussion_board
  end

end
