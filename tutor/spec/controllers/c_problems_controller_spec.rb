require 'spec_helper'

describe CProblemsController do
	include Devise::TestHelpers

	before(:each) do
		controller.class.skip_before_action :authenticate!
	end

	after(:each) do
		expect(response).to be_success
	end

	describe "GET new" do
		it "renders the contest problem creation form" do
			get :new
			expect(flash[:notice]).to be_nil
		end
	end

	describe "POST create" do
		it "creates a new contest problem" do
			expect {
				post :create, cproblem: {title: "Test", description: "Test", time_limit: 20}
			}.to change(Cproblem, :count)
			expect(flash[:notice]).to_not be_nil
		end

		it "rejects blank problem titles" do
			expect {
				post :create, cproblem: {title: "", description: "Test", time_limit: 20}
			}.to_not change(Cproblem, :count)
			expect(flash[:notice]).to_not be_nil
		end

		it "rejects blank problem descriptions" do
			expect {
				post :create, cproblem: {title: "Test", description: "", time_limit: 20}
			}.to_not change(Cproblem, :count)
			expect(flash[:notice]).to_not be_nil
		end

		it "rejects invalid problem time limits" do
			expect {
				post :create, cproblem: {title: "Test", description: "Test", time_limit: "lol"}
			}.to_not change(Cproblem, :count)
			expect(flash[:notice]).to_not be_nil
		end
	end
end
