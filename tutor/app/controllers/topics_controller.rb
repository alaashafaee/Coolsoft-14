class TopicsController < ApplicationController

    def destroy
    end

    # [Action]
    # Description: This action takes the passed course id and assings
    #              the respective course to an instance variable.
    # Author: Ahmed Akram
    def new
        @course = Course.find(params[:course_id])
    end

    # [Action]
    # Description: This action takes the passed course id and assings
    #              the respective topics of that course to an instance
    #              variable.
    # Author: Ahmed Akram
    def index
        @course = Course.find(params[:id])
        @topics = @course.topics.order("created_at desc")
    end

    # [Action]
    # Description: This action takes the passed parameters from 
    #              the creation form, creates a new Topic record
    #              and assigns it to the respective course. If the 
    #              creation fails the user is redirected to the form
    #              with a "Failed" message.
    # Author: Ahmed Akram
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

    # [Action]
    # Description: This action shows the topics of the selected course.
    # Author: Ahmed Akram
    def show
        @topic = Topic.find_by_id(params[:id])
    end

    private
        def topic_params
            params.require(:topic).permit(:title,:description, :course_id)
        end

end