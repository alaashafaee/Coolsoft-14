class CoursesController < ApplicationController
  
  def index
    @courses = current_lecturer.courses.order("created_at desc")
  end


  def destroy
  	course = Course.find_by_id(params[:id])
    course.destroy
    flash[:success] = "Course deleted."
    redirect_to :action => 'index'
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
      current_lecturer.courses << @t
      @discussion_board = DiscussionBoard.new
      @discussion_board.title = @t.name + " DiscussionBoard"
      @discussion_board.course_id = @t.id
      @discussion_board.save
      @t.discussion_board = @discussion_board
      flash[:success_creation]= "Course added."
      redirect_to :action => 'index'
      #@t.discussion_board = Discussion_board.new
      # redirect_to('show')
    else 
      render :action=>'new'    
    end
  end
  
  def edit
    @course = Course.find_by_id(params[:id])
    @discussionBoard = @course.discussion_board
  end

  def show
    @course = Course.find_by_id(params[:id])
    # @courses = Lecturer.find_by_name('Lecturer2').courses
  end

  def manage
  end

  private def course_params 
	   params.require(:course).permit(:name,:code,:year,:semester,:description)
  end

end
