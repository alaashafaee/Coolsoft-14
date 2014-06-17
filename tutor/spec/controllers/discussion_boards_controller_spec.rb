require 'spec_helper'
include Devise::TestHelpers

describe DiscussionBoardsController do
	before (:all) do
		@lecturer = Lecturer.new(email: '521@lecturer.com', password: 'Aa123456789',
			password_confirmation: 'Aa123456789', name: 'LecturerI',
			confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
			degree: "PhD", university: "GUC", department: "MET")
		@lecturer.save!

		@course = Course.new(name:"SE2",
			code:"Se2", year:2014, semester:6, :description => "last sprint",
			:link => "http://met.guc.edu.eg/")
		@course.save!
		@discussion_board = DiscussionBoard.new(title:"this is new id")
		@discussion_board.save!
		@course.discussion_board = @discussion_board
	end

	it "Check Creation validity - Activated should be false" do
		expect(@discussion_board.activated).to be false
	end
end
