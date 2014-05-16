require 'spec_helper'
include Devise::TestHelpers
describe AssignmentsController do
  before :each do
    @new_assignment = Assignment.new "Title", "Author"
end

describe "#new" do
    it "takes three parameters and returns a Book object" do
        @new_assignment.should be_an_instance_of Assignment
    end
end
describe "POST 'create'" do
    it 'should assign top videos' do
      assignment_params = { :title => 'new assignment', :description => 'assignment description' }
      get :create, :new_assignment => assignment_params
      assigns[:new_assignment].should_not be_new_record
      assigns[:new_assignment].title.should == params[:title]
      assigns[:new_assignment].description.should == params[:description]
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = FactoryGirl.create(:user)

      @article = FactoryGirl.build(:article)
      @article.user_id = @user.id
      @article.save

      @article_attributes = FactoryGirl.attributes_for(:article)
      @comment_attributes = FactoryGirl.attributes_for(:comment)
    end

    it "should create a new comment" do
      expect {
        post :create, :comment => @comment_attributes
      }.to change(Comment, :count).by(1)
    end

    it "should create a new comment, redirect to the article show page of this comment and notify the user on successful saving of the comment" do
      post :create, :comment => @comment_attributes, :article_id => @article.id.to_s, :user_id => @user.id.to_s
      flash[:notice].should_not be_nil
      response.should redirect_to(article_path(@article))
    end

  end


 


  

end
