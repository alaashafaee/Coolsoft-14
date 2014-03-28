class TracksController < ApplicationController
  
  # shows the tracks of the topic with id :id
  # show 404 page if there is no topic with such id
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

  # render a json file with a set of problems of the track with id :id
  def getProblems
  	id = params[:id]
  	track = Track.find(id)
  	problems = track.problems
  	render json: problems
  end

  # creates a new track with the passed parameters
  # if the parameters is valid a flash that it was save will show
  # and if not not a flash will show that there are fields missing
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

  # permit the passed parameters
  def permitCreate
    params.require(:Track).permit(:topic_id , :title , :difficulty)
  end
end