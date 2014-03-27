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
  end

end
