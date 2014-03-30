class TopicsController < ApplicationController
 
  def new
  end

  def index
  end

  def create
  	@t = Topic.new
  	@t.title = topic_params[:title]
  	@t.description = topic_params[:description]
  	bool = @t.save

  	if bool == true 
  		flash[:notice] = "Succeeded"
  		redirect_to :controller => 'topics', :action => 'show', :id => @t.id
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
  		params.require(:topic).permit(:title,:description)
  	end

end