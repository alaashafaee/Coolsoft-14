require 'spec_helper'

include Devise::TestHelpers

describe ResourcesController do
	
	before(:each) do
		@course_1 = Course.new(link: "http://www.google.com",
			name: "CS1", description: "Course 1",
			code: "434", year: "2014", semester: "1")
		@course_1.save!
		@course_2 = Course.new(link: "http://www.google.com",
			name: "CS2", description: "Course 2",
			code: "400", year: "2014", semester: "2")
		@course_2.save!
		lecturer = Lecturer.last
		@course_1.resources << Resource.create!(link: "youtube.com")
		@course_2.resources << Resource.create!(link: "google.com")
		@course_2.resources << Resource.create!(link: "facebook.com")
		@resource = Resource.create!(link: "twitter.com")
		@resource_new = Resource.new(link: "linkedin.com")
    	@request.env["devise.mapping"] = Devise.mappings[:lecturer]
    	lecturer.confirm!
		sign_in lecturer
	end

	describe "Resourse" do
		context "#index" do
			it "routes to index resources of course" do
				expect(:get => "/courses/#{@course_1.id}/resources").to be_routable
			end

			it "does not routes to index resources" do
				expect(:get => "/resources").not_to be_routable
			end

			it "responses with 200 Ok" do
				get :index, course_id: @course_1.id
				expect(response.status).to eq(200)
			end

			it "returns a course" do
				get :index, course_id: @course_1.id
				expect(assigns(:course)).to eq(@course_1)
			end

			it "renders a resources index page" do
				get :index, course_id: @course_1.id
				expect(response).to render_template("index")
			end
		end

		context "#destroy" do
			it "routes to destroy resource of course" do
				expect(:delete => "/courses/#{@course_1.id}/resources/#{@resource.id}")
					.to be_routable
			end

			it "does not routes to destroy resource" do
				expect(:delete => "/resources/#{@resource.id}").not_to be_routable
			end

			it "responses with 200 Ok if resource deleted successfully" do
				delete :destroy, course_id: @course_1, id: @course_1.resources.last
				expect(response.status).to eq(200)
			end

			it "responses with 404 not found if resource not found" do
				delete :destroy, course_id: @course_2, id: @course_1.resources.last
				expect(response.status).to eq(404)
			end

			it "does not delete the requested resource if not found" do
				expect {
					delete :destroy, course_id: @course_2, id: @resource
				}.to change(Resource,:count).by(0)
			end
		end

		context "#new" do
			it "routes to new resource of course" do
				expect(:get => "/courses/#{@course_1.id}/resources/new")
					.to be_routable
			end

			it "does not routes to new resource" do
				expect(:get => "/resources/new").not_to be_routable
			end

			it "responses with 200 Ok" do
				get :new, course_id: @course_1.id
				expect(response.status).to eq(200)
			end

			it "renders a resources index page" do
				get :new, course_id: @course_1.id
				expect(response).to render_template("new")
			end
		end

		context "#create" do
			it "routes to create resource of course" do
				expect(:post => "/courses/#{@course_1.id}/resources")
					.to be_routable
			end

			it "does not routes to new resource" do
				expect(:post => "/resources").not_to be_routable
			end

			it "renders a resources index page" do
				post :create, course_id: @course_1.id
				expect(response).to render_template("index")
			end

			it "deletes the resource if its field is empty" do
				expect{
					post :create, course_id: @course_1.id,
						course: { resources_attributes:
						{ "1" => {link: "", id: @course_1.resources.last.id }}}
				}.to change(Resource,:count).by(-1)
			end

			it "updates the resource if it is changed" do
				expect{
					post :create, course_id: @course_2.id,
						course: { resources_attributes:
						{ "1" => {link: "facebook.com", id: @course_2.resources.first.id }}}
				}.to change(Resource,:count).by(0)
			end

			it "updates the resource link if it is changed" do
				resource_id = @course_2.resources.first.id
				post :create, course_id: @course_2.id,
					course: { resources_attributes:
					{ "1" => {link: "facebook.com", id: @course_2.resources.first.id }}}
				expect(assigns(:course).resources.find(resource_id).link).to eq("http://facebook.com")
			end

			it "adds new resource for the course" do
				post :create, course_id: @course_2.id,
					course: { resources_attributes:
					{ "1" => {link: "youtube.com"}}}
				expect(assigns(:course).resources.last.link).to eq("http://youtube.com")
			end

			it "assigns the resource for the current lecturer" do
				resource_id = @course_2.resources.first.id
				post :create, course_id: @course_2.id,
					course: { resources_attributes:
					{ "1" => {link: "youtube.com"}}}
				expect(assigns(:current_lecturer)
					.resources.last.link).to eq("http://youtube.com")
			end
		end
	end

end