require 'spec_helper'

describe DiscussionBoard do
	it "testing validation for title: failure scenario" do
		discussion_board = DiscussionBoard.new(activated: false)
		discussion_board.save
		expect(discussion_board).not_to be_valid
	end

	it "testing validation for title: success scenario" do
		discussion_board = DiscussionBoard.new(title: "description!!!!!!!!!!!")
		discussion_board.save
		expect(discussion_board).to be_valid
	end
end
