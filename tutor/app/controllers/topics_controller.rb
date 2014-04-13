class TopicsController < ApplicationController

    def destroy
    end

    def new
        @course = Course.find(params[:course_id])
    end

    def index
        @course = Course.find(params[:id])
        @topics = @course.topics.order("created_at desc")
    end

    def create
        @new_topic = Topic.new
        @new_topic.title = topic_params[:title]
        @new_topic.description = topic_params[:description]
        bool = @new_topic.save
        if bool == true 
            flash[:notice] = "Succeeded"
            @course = Course.find(topic_params[:course_id])
            @course.topics << @new_topic
            redirect_to :controller => 'topics', :action => 'index', :id => @course.id
        else
            flash[:notice] = "Failed"
            redirect_to :back
        end
    end

    def show
        @topic = Topic.find_by_id(params[:id])
    end

    private
        def topic_params
            params.require(:topic).permit(:title,:description, :course_id)
        end

end