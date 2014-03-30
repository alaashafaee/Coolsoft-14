class CoursesController < ApplicationController
  
  def index
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    puts " "
    puts " "
    puts " "
    puts current_lecturer.id
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    puts " "
    puts " "
    puts " "
    @courses = current_lecturer.courses.all
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
