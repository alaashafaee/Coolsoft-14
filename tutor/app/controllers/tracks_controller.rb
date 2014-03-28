class TracksController < ApplicationController
  
  def show
  	id = params[:id]
    @topic = Topic.find_by_id(id)
    if @topic
     @course = @topic.course
     @tracks = @topic.tracks
    else
     render ('public/404')
    end
    if flash[:notice] != "Successfully created..." && flash[:notice] != "The required Fields are missing"
      flash[:notice]= nil
    end
  end

  def getProblems
  	id = params[:id]
  	track = Track.find(id)
  	problems = track.problems
  	render json: problems
  end

  def create
    t = Track.new(permitCreate)
  	if t.save
      flash[:notice] = "Successfully created..."
      redirect_to :back
    else
      flash[:notice] = "The required Fields are missing"
      redirect_to :back
    end
  end

  def permitCreate
    params.require(:Track).permit(:topic_id , :title , :difficulty)
  end
end