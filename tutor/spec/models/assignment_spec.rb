require 'spec_helper'

describe Assignment do
	it 'Assignment is valid with a title and description' do
		assignment = Assignment.new(
			title: 'rspec assignemt',
			description: 'This is a test assignemnt',
			due_date: Date.new(2015,1,1))
		expect(assignment).to be_valid
	end 

	it 'Assignment is invalid without title' do
		assignment = Assignment.new(
			description: 'This is a test assignemnt',
			due_date: Date.new(2015,1,1)
			)
		expect(assignment).not_to be_valid
	end 
end