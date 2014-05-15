require 'spec_helper'

describe ContestsController do
	describe "GET index" do
		it "renders the index template" do
			sign_in_lecturer
			ContestsController.skip_before_filter :autheticate!
			get :index 
			expect(response).to render_template("index")
		end
	end
end
