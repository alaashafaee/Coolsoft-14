class TopicsController < ApplicationController
 
  def new
    @course = Course.find(15)
  end

  def index
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    puts " "
    puts " "
    puts " "
    puts params[:course] == false
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    puts " "
    puts " "
    puts " "
    @course = Course.find(params[:id])
    # @topics = paTopic.all.order("created_at desc")
    @topics = @course.topics.order("created_at desc")
  end

  def create
  	@t = Topic.new
  	@t.title = topic_params[:title]
  	@t.description = topic_params[:description]
  	bool = @t.save

  	if bool == true 
  		flash[:notice] = "Succeeded"
      @course = Course.find(topic_params[:course_id])
      @course.topics << @t
  		redirect_to :controller => 'topics', :action => 'index', :id => @course.id
  	else
  		flash[:notice] = "Failed"
  		redirect_to :back
  	end
	# render text: params
  end

  def show
  	@topic = Topic.find_by_id(params[:id])
  end

  private
  	def topic_params
  		params.require(:topic).permit(:title,:description, :course_id)
  	end

end