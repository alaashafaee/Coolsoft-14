require 'spec_helper'

describe ResourcesController do
	before(:each) do
		@course_1 = Course.create!(link: "http://www.google.com",
			name: "CS1", description: "Course 1",
			code: "434", year: "2014", semester: "1")
		@course_2 = Course.create!(link: "https://www.google.com",
			name: "CS2", description: "Course 2",
			code: "400", year: "2014", semester: "2")
		@course_1.resources << Resource.create!(link: "https://www.google.com")
		@course_1.resources << Resource.create!(link: "https://www.facebook.com")
		@resource = Resource.create!(link: "http://twitter.com")
		ResourcesController.skip_before_filter :authenticate!
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

			it "deletes the requested resource of a course from database" do
				expect {
					delete :destroy, course_id: @course_1, id: @course_1.resources.first
				}.to change(Resource,:count).by(-1)
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
		end
	end

end