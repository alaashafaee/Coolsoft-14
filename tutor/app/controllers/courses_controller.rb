class CoursesController < ApplicationController
  
  def destroy
  	Course.last.destroy
    flash[:success] = "Course deleted."
    redirect_to :action => 'show'
  end

  def new
    if(@t == nil)
     @t = Course.new
   end
  end

 def create
  @t  = Course.new
  @t.name = course_params[:name]
  @t.code = course_params[:code]
  @t.year = course_params[:year]
  @t.semester = course_params[:semester]
  @t.description = course_params[:description]
  
  if @t.save
render text: "Course Successfully Created "
#@t.discussion_board = Discussion_board.new

  # redirect_to('show')
  else render :action=>'new'  
      
  end


  def show
  	render text: "Course Added Successfully"
  end

  def manage
  end

  private def course_params 
	params.require(:course).permit(:name,:code,:year,:semester,:description)
  end

end
